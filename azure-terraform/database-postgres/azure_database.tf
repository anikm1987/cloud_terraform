# Get a resource group
data "azurerm_resource_group" "demo-rg" {
  name     = var.RGName
}

# https://www.terraform.io/docs/providers/azurerm/r/postgresql_server.html
resource "azurerm_postgresql_server" "test-db-svr" {
  name                = "test-db-svr"
  location            = data.azurerm_resource_group.demo-rg.location
  resource_group_name = data.azurerm_resource_group.demo-rg.name

  # Deprecated
  # storage_profile {
  #   storage_mb            = 5120
  #   backup_retention_days = 7
  #   geo_redundant_backup  = "Disabled"
  #   auto_grow             = "Enabled"
  # }
  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  sku_name   = "GP_Gen5_4"
  version    = "11"
  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
  
}

# https://www.terraform.io/docs/providers/azurerm/r/postgresql_configuration.html
# resource "azurerm_postgresql_configuration" "example" {
#   name                = "backslash_quote"
#   resource_group_name = data.azurerm_resource_group.example.name
#   server_name         = azurerm_postgresql_server.example.name
#   value               = "on"
# }

# https://www.terraform.io/docs/providers/azurerm/r/postgresql_database.html
resource "azurerm_postgresql_database" "test-db" {
  name                = "testdb"
  resource_group_name = data.azurerm_resource_group.demo-rg.name
  server_name         = azurerm_postgresql_server.test-db-svr.name
  charset             = "utf8"
  collation           = "English_United States.1252"
}

# https://www.terraform.io/docs/providers/azurerm/r/postgresql_firewall_rule.html
# throws error as it is not enabled 
# resource "azurerm_postgresql_firewall_rule" "postgres-test-db-svc" {
#   name                = "postgres-test-db-svc"
#   resource_group_name = data.azurerm_resource_group.demo-rg.name
#   server_name         = azurerm_postgresql_server.test-db-svr.name
#   start_ip_address    = var.start_ip_address
#   end_ip_address      = var.end_ip_address
# }

# https://www.terraform.io/docs/providers/azurerm/r/postgresql_virtual_network_rule.html
# We may not require this. I dont see any option while creating from fronte end
# resource "azurerm_virtual_network" "example" {
#   name                = "example-vnet"
#   address_space       = ["10.7.29.0/29"]
#   location            = data.azurerm_resource_group.demo-rg.location
#   resource_group_name = data.azurerm_resource_group.demo-rg.name
# }

# resource "azurerm_subnet" "internal" {
#   name                 = "internal"
#   resource_group_name  = data.azurerm_resource_group.demo-rg.name
#   virtual_network_name = azurerm_virtual_network.example.name
#   address_prefix       = "10.7.29.0/29"
#   service_endpoints    = ["Microsoft.Sql"]
# }

# resource "azurerm_postgresql_virtual_network_rule" "example" {
#   name                                 = "postgresql-vnet-rule"
#   resource_group_name                  = data.azurerm_resource_group.demo-rg.name
#   server_name                          = azurerm_postgresql_server.test-db-svr.name
#   subnet_id                            = azurerm_subnet.internal.id
#   ignore_missing_vnet_service_endpoint = true
# }



