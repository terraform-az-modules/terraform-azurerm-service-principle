##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "service_principal_name" {
  description = "Display name of the Service Principal."
  value       = azuread_application.this.display_name
}

output "application_id" {
  description = "Application (client) ID of the Service Principal."
  value       = azuread_application.this.application_id
}

output "service_principal_id" {
  description = "Object ID of the Service Principal."
  value       = azuread_service_principal.this.id
}

output "client_secret" {
  description = "Client secret for the Service Principal."
  value       = azuread_service_principal_password.this.value
  sensitive   = true
}

output "tenant_id" {
  description = "Tenant ID of the current Azure AD tenant."
  value       = data.azurerm_client_config.current.tenant_id
}
