# data "key_vault_secret" "kv" {
#     name = var.key_vault_name
#     resource_group_name = var.resource_group_name
# }

data "azurerm_key_vault_secret" "kv" {
  name         = var.secret_name
  key_vault_id = var.key_vault_id
}