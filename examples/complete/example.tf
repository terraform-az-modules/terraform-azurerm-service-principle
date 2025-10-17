provider "azurerm" {
  features {}
}

provider "azuread" {}

##-----------------------------------------------------------------------------
## Resource Group module call
##-----------------------------------------------------------------------------
module "resource_group" {
  source      = "terraform-az-modules/resource-group/azure"
  version     = "1.0.0"
  name        = "core"
  environment = "dev"
  location    = "centralus"
  label_order = ["name", "environment", "location"]
}

##-----------------------------------------------------------------------------
## Service Principal module call
##-----------------------------------------------------------------------------
module "service_principal" {
  source              = "../../"
  name                = "core"
  environment         = "dev"
  role_name           = "Contributor"
  label_order         = ["name", "environment", "location"]
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
}
