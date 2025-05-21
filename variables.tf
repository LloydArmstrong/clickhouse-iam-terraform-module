variable "service_id" {
  type = string
}

variable "roles" {
  type = map(any)
}

variable "privileges_per_role" {
  type = map(object({
    privilege_names = list(string)
    database_names  = optional(list(string))
  }))
}