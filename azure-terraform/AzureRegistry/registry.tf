# Get a resource group
data "azurerm_resource_group" "example-rg" {
  name     = var.RGName
}

# resource "random_string" "random-name" {
#   length  = 8
#   upper   = false
#   lower   = false
#   number  = true
#   special = false
# }

resource "azurerm_container_registry" "demo-app" {
  name                     = var.ACRName
  location                 = data.azurerm_resource_group.example-rg.location
  resource_group_name      = data.azurerm_resource_group.example-rg.name
  sku                      = "Standard"
  admin_enabled            = false
}
