##-----------------------------------------------------------------------------
## Standard Tagging Module – Applies standard tags to all resources for traceability
##-----------------------------------------------------------------------------
module "labels" {
  source          = "terraform-az-modules/tags/azurerm"
  version         = "1.0.2"
  name            = var.custom_name == null ? var.name : var.custom_name
  location        = var.location
  environment     = var.environment
  managedby       = var.managedby
  label_order     = var.label_order
  repository      = var.repository
  deployment_mode = var.deployment_mode
  extra_tags      = var.extra_tags
}

##-------------------------------
## Azure AD Application
##-------------------------------
resource "azuread_application" "sp" {
  count        = var.enable ? 1 : 0
  display_name = var.name
  owners       = [var.owner_object_id]

  # Single web block with all redirect URIs
  web {
    redirect_uris = var.redirect_uris
    # Only one logout URL is allowed
    logout_url = length(var.front_channel_logout_urls) > 0 ? var.front_channel_logout_urls[0] : null
  }

  # Dynamic API Permissions
  dynamic "required_resource_access" {
    for_each = local.required_permissions
    content {
      resource_app_id = required_resource_access.value.resource_app_id

      dynamic "resource_access" {
        for_each = required_resource_access.value.resource_access
        content {
          id   = resource_access.value.id
          type = resource_access.value.type
        }
      }
    }
  }
}

# -------------------------------
# Service Principal
# -------------------------------
resource "azuread_service_principal" "sp" {
  count                        = var.enable ? 1 : 0
  client_id                    = azuread_application.sp[0].client_id
  app_role_assignment_required = false
  owners                       = [var.owner_object_id]
}

# -------------------------------
# Secrets
# -------------------------------
resource "azuread_application_password" "sp_secrets" {
  for_each = var.enable ? var.secret_map : {}

  application_id = azuread_application.sp[0].id
  display_name   = each.key
  end_date       = timeadd(timestamp(), each.value)
}