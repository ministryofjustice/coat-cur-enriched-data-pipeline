import awswrangler as wr
from config import path_to_partitions, database_name, table_name
from partitions import filter_billing_periods, create_partition_map

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
