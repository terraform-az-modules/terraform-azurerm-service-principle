##-----------------------------------------------------------------------------
## Resources
##-----------------------------------------------------------------------------
resource "azuread_application" "this" {
  display_name = local.combined_name
}

resource "azuread_service_principal" "this" {
  application_id = azuread_application.this.application_id
}

resource "azuread_service_principal_password" "this" {
  service_principal_id = azuread_service_principal.this.id
  end_date_relative    = "8760h" # 1 year
}

# Optional Role Assignment (at resource group level)
resource "azurerm_role_assignment" "this" {
  count                = var.role_name != null ? 1 : 0
  scope                = data.azurerm_resource_group.rg.id
  role_definition_name = var.role_name
  principal_id         = azuread_service_principal.this.id
}
