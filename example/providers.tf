terraform {
  required_version = "< 2.0"
  required_providers {
    clickhouse = {
      source  = "ClickHouse/clickhouse"
      version = "3.2.0-alpha1"
    }
  }
}

provider "clickhouse" {
  organization_id = var.organization_id
}
