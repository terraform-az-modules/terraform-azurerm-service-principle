##-----------------------------------------------------------------------------
## Azure AD Application
##-----------------------------------------------------------------------------
resource "azuread_application" "sp" {
  count        = var.enable ? 1 : 0
  display_name = var.name
  owners       = [var.owner_object_id]

  web {
    redirect_uris = var.redirect_uris
    logout_url    = length(var.front_channel_logout_urls) > 0 ? var.front_channel_logout_urls[0] : null
  }


  dynamic "required_resource_access" {
    for_each = var.enable_api_permission ? local.required_permissions : []
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

##-----------------------------------------------------------------------------
## Service Principal
##-----------------------------------------------------------------------------
resource "azuread_service_principal" "sp" {
  count                        = var.enable ? 1 : 0
  client_id                    = azuread_application.sp[0].client_id
  app_role_assignment_required = false
  owners                       = [var.owner_object_id]
}

##-----------------------------------------------------------------------------
## Secret Rotation Tracker
##-----------------------------------------------------------------------------
resource "time_rotating" "secret_expiry" {
  for_each      = var.enable ? var.secret_map : {}
  rotation_days = 180
}

##-----------------------------------------------------------------------------
## Secrets (Stable Rotation)
##-----------------------------------------------------------------------------
resource "azuread_application_password" "sp_secrets" {
  for_each = var.enable ? var.secret_map : {}

  application_id = azuread_application.sp[0].id
  display_name   = each.key

  # How long the secret stays valid, based on user input (e.g., "4380h", "8760h")
  end_date = timeadd(time_rotating.secret_expiry[each.key].rfc3339, each.value)

  # Rotate only when rotation period triggers
  rotate_when_changed = {
    rotation = time_rotating.secret_expiry[each.key].id
  }
}
