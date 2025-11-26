provider "azurerm" {
  features {}
}

provider "azuread" {}

data "azuread_client_config" "current" {}

##-----------------------------------------------------------------------------
## Service Principal module call
##-----------------------------------------------------------------------------
module "service_principal" {
  source          = "../../"
  name            = "my-sp"
  location        = "centralcanada"
  owner_object_id = data.azuread_client_config.current.object_id
  # Multiple redirect URIs are allowed
  redirect_uris = [
    "https://localhost/",
    "https://myapp.com/callback",
    "https://myapp.com/redirect"
  ]

  # Only the first logout URL is supported by azuread_application resource
  front_channel_logout_urls = [
    "https://localhost/logout"
  ]
  secret_map = {
    secret1 = "4380h"  # 6 months
    secret2 = "8760h"  # 1 year
    secret3 = "13140h" # 1.5 years
  }
  enable_api_permission = true
}