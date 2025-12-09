from datetime import datetime
from dateutil.relativedelta import relativedelta

def filter_billing_periods(billing_period_list, date_limit = datetime.now() - relativedelta(years=1)):
    billing_period_list = [
        bp for bp in billing_period_list
        if datetime.strptime(bp.split('=')[1], "%Y-%m") >= date_limit
    ]

def create_partition_map(path_to_partitions, partition_list):
    partitions_values = {}

    for billing_period in partition_list:
        key = prefix + billing_period + "/"
        value = [billing_period.split("=")[1]]
        partitions_values[key] = value

    return partitions_values