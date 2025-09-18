resource "azurerm_key_vault_secret" "kvsecret" {
  name         = var.secret_name
  value        = var.secret_value
#   key_vault_id = data.key_vault_secret.kv.id
key_vault_id = var.key_vault_id
}

