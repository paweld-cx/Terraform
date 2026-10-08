terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.112"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_key_vault" "vault" {
  name                = "kv-pawel-proxmox"
  resource_group_name = "PDtest"
}

data "azurerm_key_vault_secret" "proxmox" {
  name         = "proxmox-api-token"
  key_vault_id = data.azurerm_key_vault.vault.id
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  api_token = data.azurerm_key_vault_secret.proxmox.value
  insecure  = true
}
