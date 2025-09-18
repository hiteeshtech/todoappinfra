module "resource_group" {
  source              = "../child_module/azurerm_resource_group"
  resource_group_name = "RG_Hitesh_Todoappinfra"
  location            = "Central India"
}

module "vnet" {
  depends_on           = [module.resource_group]
  source               = "../child_module/azurerm_VNET"
  virtual_network_name = "VNET_Hitesh_Todoinfra"
  resource_group_name  = "RG_Hitesh_Todoappinfra"
  location             = "Central India"
  address_space        = ["10.0.0.0/16"]
}

module "subnet" {
  depends_on           = [module.vnet]
  source               = "../child_module/azurerm_subnet"
  subnet_name          = "subnet_Hitesh_todoinfra"
  resource_group_name  = "RG_Hitesh_Todoappinfra"
  virtual_network_name = "VNET_Hitesh_Todoinfra"
  address_prefixes     = ["10.0.0.0/24"]
}

module "public_ip" {
  depends_on          = [module.resource_group]
  source              = "../child_module/azurerm_public_ip"
  public_ip_name      = "pip_Hitesh_todoinfra"
  resource_group_name = "RG_Hitesh_Todoappinfra"
  location            = "Central India"
  allocation_method   = "Static"
}

module "sql_server" {
  sql_server_name              = "hiteshsqlservertodoappinfra"
  source                       = "../child_module/azurerm_sql_server"
  resource_group_name          = "RG_Hitesh_Todoappinfra"
  location                     = "Central India"
  administrator_login          = "sharmah91"
  administrator_login_password = "Hitesh1001@@"
  depends_on                   = [module.resource_group]
}

module "sql_database" {
  source              = "../child_module/azurerm_sql_database"
  sql_database_name   = "hiteshsqldatabsetodoappinfra"
  sql_server_name     = "hiteshsqlservertodoappinfra"
  resource_group_name = "RG_Hitesh_Todoappinfra"
  depends_on          = [module.sql_server]
}

module "key_vault" {
  key_vault_name      = "kvhiteshtodoappinfra"
  resource_group_name = "RG_Hitesh_Todoappinfra"
  location            = "Central India"
  source              = "../child_module/azurerm_keyvault"
}

module "vm_password" {
  source     = "../child_module/azurerm_keyvault_secret"
  depends_on = [module.key_vault]
  # key_vault_name      = "kvhiteshtodoappinfra"
  # resource_group_name = "RG_Hitesh_Todoappinfra"
  key_vault_id = module.key_vault.key_vault_id
  secret_name  = "vm-password"
  secret_value = "Hitesh1001@@"
}

module "vm_username" {
  source     = "../child_module/azurerm_keyvault_secret"
  depends_on = [module.key_vault]
  # key_vault_name      = "kvhiteshtodoappinfra"
  # resource_group_name = "RG_Hitesh_Todoappinfra"
  key_vault_id = module.key_vault.key_vault_id
  secret_name  = "vm-username"
  secret_value = "sharmah91"
}

module "virtual_machine" {
  depends_on = [module.subnet, module.key_vault, module.vm_username, module.vm_password, module.public_ip]
  source     = "../child_module/azurerm_virtual_machine"

  resource_group_name  = "RG_Hitesh_Todoappinfra"
  location             = "centralindia"
  vm_name              = "hiteshvmtodoinfra"
  vm_size              = "Standard_B1s"
  admin_username       = "sharmah91"
  image_publisher      = "Canonical"
  image_offer          = "0001-com-ubuntu-server-focal"
  image_sku            = "20_04-lts"
  image_version        = "latest"
  nic_name             = "hitesh_nic_todoappinfra"
  public_ip_name       = "pip_Hitesh_todoinfra"
  vnet_name            = "VNET_Hitesh_Todoinfra"
  subnet_name          = "subnet_Hitesh_todoinfra"
  key_vault_name       = "kvhiteshtodoappinfra"
  username_secret_name = "vm-username"
  password_secret_name = "vm-password"
}