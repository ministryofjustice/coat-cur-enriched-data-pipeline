import awswrangler as wr
import os
from partitions import filter_billing_periods, create_partition_map

mode = os.environ.get('MODE')

bucket = "s3://mojap-data-production-coat-cur-reports-v2-hourly-enriched/"
prefix_to_billing_periods = ""
path_to_partitions = bucket + prefix_to_billing_periods
database_name = "cloud_optimisation_and_accountability"

if mode == "dev":
    table_name = "mojap_cur_enriched_data_dev"
elif mode == "prod":
    table_name = "mojap_cur_enriched_data"

columns_types, partitions_types = wr.s3.read_parquet_metadata(path=path_to_partitions, dataset=True)

wr.catalog.create_parquet_table(
    database = database_name,
    table = table_name,
    path = path_to_partitions,
    columns_types = columns_types,
    partitions_types = partitions_types,
    compression = "snappy",
    table_type = "EXTERNAL_TABLE",
    mode= "overwrite"
)

s3_objects = wr.s3.list_objects(path_to_partitions)

billing_period_list = list(set([object.removeprefix(path_to_partitions).split('/')[0] for object in s3_objects]))

billing_period_list.sort()

filter_billing_periods(billing_period_list)

partitions_values = create_partition_map(path_to_partitions, billing_period_list)

wr.catalog.add_parquet_partitions(
    database=database_name,
    table=table_name,
    partitions_values=partitions_values
)
