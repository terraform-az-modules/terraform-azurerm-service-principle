##-----------------------------------------------------------------------------
## Locals
##-----------------------------------------------------------------------------
locals {
  label_order = var.label_order
  sp_name     = "${var.name}-sp"
  name = var.custom_name != null ? var.custom_name : var.name
}
