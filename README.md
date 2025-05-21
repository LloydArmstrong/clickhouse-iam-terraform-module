
# ClickHouse Roles and Privileges Terraform Module

This Terraform module creates ClickHouse roles and assigns privileges to each role using the [ClickHouse Terraform Provider](https://registry.terraform.io/providers/ClickHouse/clickhouse/latest).

**NB!!! The module does not handle column and table specific permissions yet. Only creating Roles and assigning priveleges to Roles. Upcoming updates will add additional funtionality.**

---

## 📦 Module Structure

- `main.tf` — Defines roles and grants privileges to each role
- `variables.tf` — Input variable definitions
- `outputs.tf` — Exports created roles

---

## ✅ Requirements

- Terraform 1.3+
- ClickHouse Terraform Provider (v3+)
- ClickHouse Cloud or compatible service

---

## 🔧 Usage

```hcl
module "clickhouse_roles" {
  source     = "./modules/clickhouse_roles"
  service_id = "your-clickhouse-service-id"

  roles = {
    erp_engineer = {}
    grafana      = {}
    bida         = {}
  }

  privileges_per_role = {
    erp_engineer = [
      {
        privilege_name      = "SELECT"
        database_name       = "erp"
        grant_on_all_tables = true
      },
      {
        privilege_name = "INSERT"
        database_name  = "erp"
        table_name     = "invoices"
      }
    ]

    grafana = [
      {
        privilege_name = "SELECT"
        database_name  = "monitoring"
        table_name     = "metrics"
      }
    ]

    bida = [
      {
        privilege_name = "SELECT"
        database_name  = "analytics"
        grant_on_all_tables = true
      }
    ]
  }
}
```

---

## 🔑 Inputs

| Variable             | Type     | Description                       |
|----------------------|----------|-----------------------------------|
| `service_id`         | `string` | ClickHouse service ID             |
| `roles`              | `map`    | Role names to create              |
| `privileges_per_role`| `map(list(object))` | Privileges per role    |

---

## 📤 Outputs

| Output   | Description              |
|----------|--------------------------|
| `roles`  | Map of created roles     |

---

## 🧪 Example

See the example above to assign different privileges to different roles.

---