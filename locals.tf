##-----------------------------------------------------------------------------
## Locals
##-----------------------------------------------------------------------------
locals {
  labels = {
    name        = var.name
    environment = var.environment
    location    = var.location
  }

  combined_name = var.custom_name != null ? var.custom_name : join("-", [for key in var.label_order : lookup(local.labels, key, "")])
}
