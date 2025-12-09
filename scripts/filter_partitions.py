from datetime import datetime
from dateutil.relativedelta import relativedelta

def filter_billing_periods(billing_periods, date_limit = datetime.now() - relativedelta(years=1))
    billing_periods = [
        bp for bp in billing_periods
        if datetime.strptime(bp.split('=')[1], "%Y-%m") >= date_limit
    ]