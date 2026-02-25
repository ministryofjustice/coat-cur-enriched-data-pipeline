from datetime import datetime

import pytest

from scripts.partitions import filter_billing_periods, create_partition_map


class TestFilterBillingPeriods:
    def test_filters_only_billing_period_entries(self):
        items = [
            "BILLING_PERIOD=2025-01",
            "OTHER_KEY=2025-01",
            "BILLING_PERIOD=2025-02",
            "random_string",
        ]
        date_limit = datetime(2024, 1, 1)
        result = filter_billing_periods(items, date_limit=date_limit)
        assert result == ["BILLING_PERIOD=2025-01", "BILLING_PERIOD=2025-02"]

    def test_respects_explicit_date_limit(self):
        items = [
            "BILLING_PERIOD=2024-06",
            "BILLING_PERIOD=2025-01",
            "BILLING_PERIOD=2025-03",
        ]
        date_limit = datetime(2025, 1, 1)
        result = filter_billing_periods(items, date_limit=date_limit)
        assert result == ["BILLING_PERIOD=2025-01", "BILLING_PERIOD=2025-03"]

    def test_empty_list_returns_empty(self):
        result = filter_billing_periods([], date_limit=datetime(2020, 1, 1))
        assert result == []

    def test_unexpected_folders_are_excluded(self):
        items = [
            "STAGING/",
            "BILLING_PERIOD=2025-01",
            "tmp_data",
            "OTHER_KEY=2025-02",
        ]
        date_limit = datetime(2020, 1, 1)
        result = filter_billing_periods(items, date_limit=date_limit)
        assert result == ["BILLING_PERIOD=2025-01"]

    def test_all_entries_before_date_limit_returns_empty(self):
        items = [
            "BILLING_PERIOD=2023-01",
            "BILLING_PERIOD=2023-06",
        ]
        result = filter_billing_periods(items, date_limit=datetime(2025, 1, 1))
        assert result == []

    def test_invalid_date_format_raises(self):
        items = ["BILLING_PERIOD=not-a-date"]
        with pytest.raises(ValueError):
            filter_billing_periods(items, date_limit=datetime(2020, 1, 1))


class TestCreatePartitionMap:
    def test_returns_correct_keys_and_values(self):
        path = "s3://bucket/data/"
        partitions = [
            "BILLING_PERIOD=2025-01",
            "BILLING_PERIOD=2025-02",
        ]
        result = create_partition_map(path, partitions)
        assert result == {
            "s3://bucket/data/BILLING_PERIOD=2025-01/": ["2025-01"],
            "s3://bucket/data/BILLING_PERIOD=2025-02/": ["2025-02"],
        }

    def test_empty_partition_list_returns_empty_dict(self):
        result = create_partition_map("s3://bucket/data/", [])
        assert result == {}
