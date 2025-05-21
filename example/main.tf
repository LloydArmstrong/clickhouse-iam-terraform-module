locals {
  read  = ["SELECT", "SHOW"]
  write = ["INSERT", "ALTER DELETE", "TRUNCATE", "ALTER"]
  create = ["CREATE", "DROP"]
  all_privileges   = concat(local.read, local.write, local.create)
}

module "clickhouse_roles" {
  source     = "github.com/LloydArmstrong/clickhouse-iam-terraform-module"
  service_id = clickhouse_service.datawarehouse.id

  roles = {
    admin               = {}
    airbyte             = {}
    dagster             = {}
    engineers           = {}
  }

  privileges_per_role = {
    admin = {
      privilege_names = local.all_privileges
    }
    
    airbyte = {
      privilege_names = local.all_privileges
      database_names  = ["airbyte_%"]
    }

    dagster = {
      privilege_names = local.all_privileges
      database_names  = ["dagster_%", "prod_%"]
    }

    engineers = {
      privilege_names = local.read
      database_names  = ["airbyte_%", "dagster_%", "prod_%"]
    }
  }
}