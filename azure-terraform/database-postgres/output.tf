output "postgressql_fqdn" {
  value = azurerm_postgresql_server.test-db-svr.fqdn
}

output "postgressql_db_name" {
  value = azurerm_postgresql_database.test-db.name
}

