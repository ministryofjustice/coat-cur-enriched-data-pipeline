from datetime import datetime

def parse_billing_period(bp):
    return datetime.strptime(bp.split('=')[1], "%Y-%m")