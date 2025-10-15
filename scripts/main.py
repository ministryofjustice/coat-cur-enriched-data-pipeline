import awswrangler as wr
import os
from datetime import datetime
from dateutil.relativedelta import relativedelta

# Use this script to create a new table or to recreate an
# existing table (overwrite).

# 0. Collect environment variable set in Airflow workflow
mode = os.environ.get('MODE')

# 1. Set variables
bucket = "s3://mojap-data-production-coat-cur-reports-v2-hourly/"
prefix_to_billing_periods = "moj-cost-and-usage-reports/MOJ-CUR-V2-HOURLY/data/"
path_to_partitions = bucket + prefix_to_billing_periods
database_name = "cloud_optimisation_and_accountability"
if mode == "dev":
    table_name = "mojap_cur_data_dev"
elif mode == "prod":
    table_name = "mojap_cur_data"

# 2. Read metadata information to get columns_types metadata in dict form: {'col0': 'bigint', 'col1': 'double'}
# With dataset as true collects partitions_value
columns_types, partitions_types = wr.s3.read_parquet_metadata(path=path_to_partitions, dataset=True)

# 3. Write table; point at the .../data/ folder under which are all the partitions
wr.catalog.create_parquet_table(
    database = database_name,
    table = table_name,
    path = path_to_partitions,
    columns_types = columns_types,
    partitions_types = partitions_types,
    compression = "snappy", # pass the existing file compression type
    table_type = "EXTERNAL_TABLE",
    mode= "overwrite" # "append", or "overwrite" to recreate any possibly existing table
)

# 4. Add partitions
# Despite setting the partition value the partitions are not recognised, need to add them one by one
# 4a. Get list of objects in s3, to loop through and add partitions
s3_objects = wr.s3.list_objects(path_to_partitions)
prefix = 's3://mojap-data-production-coat-cur-reports-v2-hourly/moj-cost-and-usage-reports/MOJ-CUR-V2-HOURLY/data/'
billing_period_list = list(set([object.removeprefix(prefix).split('/')[0] for object in s3_objects]))
billing_period_list.sort()
# returns ['BILLING_PERIOD=2022-04',...,'BILLING_PERIOD=2025-08']

# Filter out partitions beyond 1 year ago
one_year_ago = datetime.now() - relativedelta(years=1)

def parse_billing_period(bp):
    return datetime.strptime(bp.split('=')[1], "%Y-%m")

recent_billing_periods = [
    bp for bp in billing_period_list
    if parse_billing_period(bp) >= one_year_ago
]

# 4b. Create dictionary of partitions to add
partitions_values = {}
for billing_period in recent_billing_periods:
    key = prefix + billing_period + "/"
    value = [billing_period.split("=")[1]]
    partitions_values[key] = value

# 4c. Add partitions
wr.catalog.add_parquet_partitions(
    database=database_name,
    table=table_name,
    partitions_values=partitions_values
)

# 4d. Check partitions is non-empty
added_partitions_dict = wr.catalog.get_partitions(
    database=database_name,
    table=table_name,
)
added_partitions_list = [item[0] for item in list(added_partitions_dict.values())]
added_partitions_list.sort()
print(f"Number of partitions added: {len(added_partitions_list)}")
print(added_partitions_list)
