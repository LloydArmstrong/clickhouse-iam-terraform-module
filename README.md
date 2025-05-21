
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

This creates the specific roles

```hcl
module "clickhouse_roles" {
  source     = "github.com/LloydArmstrong/clickhouse-iam-terraform-module"
  service_id = clickhouse_service.datawarehouse.id

  roles = {
    admin               = {}
    airbyte             = {}
    dagster             = {}
    engineers           = {}
  }
```

...and then we add privileges to these created roles.

```hcl
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