import awswrangler as wr
import os
from filter_partitions import filter_billing_periods

mode = os.environ.get('MODE')

bucket = "s3://mojap-data-production-coat-cur-reports-v2-hourly-enriched/"
database_name = "cloud_optimisation_and_accountability"

if mode == "dev":
    table_name = "mojap_cur_enriched_data_dev"
elif mode == "prod":
    table_name = "mojap_cur_enriched_data"

columns_types, partitions_types = wr.s3.read_parquet_metadata(path=bucket, dataset=True)

wr.catalog.create_parquet_table(
    database = database_name,
    table = table_name,
    path = bucket,
    columns_types = columns_types,
    partitions_types = partitions_types,
    compression = "snappy",
    table_type = "EXTERNAL_TABLE",
    mode= "overwrite"
)

s3_objects = wr.s3.list_objects(bucket)

billing_period_list = list(set(s3_objects))

billing_period_list.sort()

filter_billing_periods(billing_period_list)

partitions_values = {}

for billing_period in billing_period_list:
    key = billing_period + "/"
    value = [billing_period.split("=")[1]]
    partitions_values[key] = value

wr.catalog.add_parquet_partitions(
    database=database_name,
    table=table_name,
    partitions_values=partitions_values
)
