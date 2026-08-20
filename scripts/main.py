import awswrangler as wr
from config import (
    path_to_partitions,
    database_name,
    table_name,
)
from partitions import extract_billing_periods, filter_billing_periods, create_partition_map


def build_enriched_table(path, database, table):
    """Create/overwrite a Glue external table for a billing-period dataset.

    `path` must be the root that directly contains BILLING_PERIOD=YYYY-MM/ folders.
    """
    columns_types, partitions_types = wr.s3.read_parquet_metadata(path=path, dataset=True)

    wr.catalog.create_parquet_table(
        database=database,
        table=table,
        path=path,
        columns_types=columns_types,
        partitions_types=partitions_types,
        compression="snappy",
        table_type="EXTERNAL_TABLE",
        mode="overwrite",
    )

    s3_objects = wr.s3.list_objects(path)

    billing_period_list = extract_billing_periods(s3_objects, path)

    billing_period_list_filtered = filter_billing_periods(billing_period_list)

    partitions_values = create_partition_map(path, billing_period_list_filtered)

    wr.catalog.add_parquet_partitions(
        database=database,
        table=table,
        partitions_values=partitions_values,
    )


build_enriched_table(path_to_partitions, database_name, table_name)
