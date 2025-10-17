##-----------------------------------------------------------------------------
## Outputs
##-----------------------------------------------------------------------------
output "app_id" {
  value = module.service_principal.application_id
}

output "sp_id" {
  value = module.service_principal.service_principal_id
}

output "tenant_id" {
  value = module.service_principal.tenant_id
}

output "client_secret" {
  value     = module.service_principal.client_secret
  sensitive = true
}
