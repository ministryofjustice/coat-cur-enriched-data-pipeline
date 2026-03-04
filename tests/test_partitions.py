from datetime import datetime

import pytest

from scripts.partitions import extract_billing_periods, filter_billing_periods, create_partition_map


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


class TestExtractBillingPeriods:
    def test_extracts_billing_periods_from_s3_paths(self):
        prefix = "s3://bucket/data/"
        s3_objects = [
            "s3://bucket/data/BILLING_PERIOD=2025-01/file1.parquet",
            "s3://bucket/data/BILLING_PERIOD=2025-02/file2.parquet",
        ]
        result = extract_billing_periods(s3_objects, prefix)
        assert result == ["BILLING_PERIOD=2025-01", "BILLING_PERIOD=2025-02"]

    def test_deduplicates_billing_periods(self):
        prefix = "s3://bucket/data/"
        s3_objects = [
            "s3://bucket/data/BILLING_PERIOD=2025-01/file1.parquet",
            "s3://bucket/data/BILLING_PERIOD=2025-01/file2.parquet",
            "s3://bucket/data/BILLING_PERIOD=2025-02/file3.parquet",
        ]
        result = extract_billing_periods(s3_objects, prefix)
        assert result == ["BILLING_PERIOD=2025-01", "BILLING_PERIOD=2025-02"]

    def test_returns_sorted_results(self):
        prefix = "s3://bucket/data/"
        s3_objects = [
            "s3://bucket/data/BILLING_PERIOD=2025-03/file.parquet",
            "s3://bucket/data/BILLING_PERIOD=2025-01/file.parquet",
            "s3://bucket/data/BILLING_PERIOD=2025-02/file.parquet",
        ]
        result = extract_billing_periods(s3_objects, prefix)
        assert result == ["BILLING_PERIOD=2025-01", "BILLING_PERIOD=2025-02", "BILLING_PERIOD=2025-03"]

    def test_empty_list_returns_empty(self):
        result = extract_billing_periods([], "s3://bucket/data/")
        assert result == []

    def test_handles_non_billing_period_folders(self):
        prefix = "s3://bucket/data/"
        s3_objects = [
            "s3://bucket/data/BILLING_PERIOD=2025-01/file.parquet",
            "s3://bucket/data/STAGING/file.parquet",
            "s3://bucket/data/OTHER_KEY=2025-01/file.parquet",
        ]
        result = extract_billing_periods(s3_objects, prefix)
        assert result == ["BILLING_PERIOD=2025-01", "OTHER_KEY=2025-01", "STAGING"]

    def test_handles_nested_paths(self):
        prefix = "s3://bucket/data/"
        s3_objects = [
            "s3://bucket/data/BILLING_PERIOD=2025-01/subdir/file.parquet",
        ]
        result = extract_billing_periods(s3_objects, prefix)
        assert result == ["BILLING_PERIOD=2025-01"]


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
