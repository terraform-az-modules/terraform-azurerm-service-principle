##-----------------------------------------------------------------------------
## Permissions, Roles, and Policies
##-----------------------------------------------------------------------------

# Application Roles (Dynamic)
resource "azuread_application_app_role" "roles" {
  for_each = var.enable ? {
    for role in var.application_roles :
    role.value => role
  } : {}

  application_id       = azuread_application.sp[0].id
  display_name         = each.value.display_name
  value                = each.value.value
  description          = each.value.description
  role_id              = uuid()
  allowed_member_types = each.value.allowed_member_types
}

locals {
  required_permissions = [
    {
      resource_app_id = var.resource_app_id
      resource_access = var.api_permissions
    }
  ]
}

# Assign App Roles to the SP (Dynamic)
resource "azuread_app_role_assignment" "assign_roles" {
  for_each = var.enable ? azuread_application_app_role.roles : {}

  app_role_id         = each.value.role_id
  principal_object_id = azuread_service_principal.sp[0].object_id
  resource_object_id  = azuread_service_principal.sp[0].object_id
}

# Optional Azure RBAC Assignment
resource "azurerm_role_assignment" "sp_role" {
  count = var.enable_role_assignment ? 1 : 0

  scope                = var.role_scope != null ? var.role_scope : data.azurerm_subscription.current.id
  role_definition_name = var.role_definition_name
  principal_id         = azuread_service_principal.sp[0].object_id
}
