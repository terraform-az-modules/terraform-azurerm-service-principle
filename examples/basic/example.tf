provider "azurerm" {
  features {}
}

module "service-principle" {
  source = "../../"
}
