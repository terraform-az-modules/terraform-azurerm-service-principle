##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------

output "service_principal_id" {
  value       = var.enable ? azuread_service_principal.sp[0].id : null
  description = "The ID (object ID) of the created Service Principal"
}

output "service_principal_client_id" {
  value       = var.enable ? azuread_service_principal.sp[0].client_id : null
  description = "The Client ID (App ID) of the Service Principal"
}

output "service_principal_display_name" {
  value       = var.enable ? azuread_service_principal.sp[0].display_name : null
  description = "The display name of the Service Principal"
}

output "application_object_id" {
  value       = var.enable ? azuread_application.sp[0].id : null
  description = "The object ID of the Azure AD Application"
}

output "service_principal_secrets" {
  value = var.enable ? {
    for name, secret in azuread_application_password.sp_secrets :
    name => {
      id    = secret.id
      value = secret.value
    }
  } : {}
  sensitive   = true
  description = "Map of secret names to their ID and value"
}
