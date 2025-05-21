resource "clickhouse_role" "role" {
  for_each   = var.roles
  service_id = var.service_id
  name       = each.key
}

resource "clickhouse_grant_privilege" "privileges" {
  for_each = {
    for role_db_priv in flatten([
      for role_name, config in var.privileges_per_role : (
        config.database_names != null ?
        [
          for db in config.database_names : [
            for priv in config.privilege_names : {
              role_name      = role_name
              database_name  = db
              privilege_name = priv
              key            = "${role_name}-${db}-${priv}"
            }
          ]
        ] : []
      )
    ]) : role_db_priv.key => role_db_priv
  }

  service_id         = var.service_id
  privilege_name     = each.value.privilege_name
  database_name      = each.value.database_name
  grantee_role_name  = clickhouse_role.role[each.value.role_name].name
}