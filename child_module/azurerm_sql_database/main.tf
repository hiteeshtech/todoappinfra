resource "azurerm_mssql_database" "sqldatab" {
  name         = var.sql_database_name
  server_id    = data.azurerm_mssql_server.sqls.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
}



