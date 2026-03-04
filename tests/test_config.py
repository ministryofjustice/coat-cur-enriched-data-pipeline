import importlib
import os

import scripts.config as config_module


class TestConfigTableName:
    def _reload_config(self, mode_value=None):
        if mode_value is not None:
            os.environ["MODE"] = mode_value
        elif "MODE" in os.environ:
            del os.environ["MODE"]
        return importlib.reload(config_module)

    def test_dev_mode_sets_dev_table(self):
        cfg = self._reload_config("dev")
        assert cfg.table_name == "mojap_cur_enriched_data_dev"

    def test_prod_mode_sets_prod_table(self):
        cfg = self._reload_config("prod")
        assert cfg.table_name == "mojap_cur_enriched_data"

    def test_unset_mode_defaults_to_dev_table(self):
        cfg = self._reload_config(None)
        assert cfg.table_name == "mojap_cur_enriched_data_dev"

    def test_unknown_mode_defaults_to_dev_table(self):
        cfg = self._reload_config("staging")
        assert cfg.table_name == "mojap_cur_enriched_data_dev"
