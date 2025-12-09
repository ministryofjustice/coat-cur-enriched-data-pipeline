import os

mode = os.environ.get('MODE')

bucket = "s3://mojap-data-production-coat-cur-reports-v2-hourly-enriched/"
prefix_to_billing_periods = ""
path_to_partitions = bucket + prefix_to_billing_periods
database_name = "cloud_optimisation_and_accountability"

if mode == "dev":
    table_name = "mojap_cur_enriched_data_dev"
elif mode == "prod":
    table_name = "mojap_cur_enriched_data"