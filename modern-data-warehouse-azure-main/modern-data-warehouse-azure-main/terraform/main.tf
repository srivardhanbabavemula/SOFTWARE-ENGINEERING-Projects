terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "dw_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Storage Account with Data Lake Gen2
resource "azurerm_storage_account" "datalake" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.dw_rg.name
  location                 = azurerm_resource_group.dw_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled          = true

  tags = var.tags
}

resource "azurerm_storage_data_lake_gen2_filesystem" "raw" {
  name               = "raw"
  storage_account_id = azurerm_storage_account.datalake.id
}

resource "azurerm_storage_data_lake_gen2_filesystem" "curated" {
  name               = "curated"
  storage_account_id = azurerm_storage_account.datalake.id
}

# Azure Synapse Workspace
resource "azurerm_synapse_workspace" "synapse" {
  name                                 = var.synapse_workspace_name
  resource_group_name                  = azurerm_resource_group.dw_rg.name
  location                            = azurerm_resource_group.dw_rg.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.raw.id
  sql_administrator_login             = var.synapse_sql_admin_username
  sql_administrator_login_password    = var.synapse_sql_admin_password

  tags = var.tags
}

# Synapse SQL Pool
resource "azurerm_synapse_sql_pool" "sqlpool" {
  name                 = var.synapse_sql_pool_name
  synapse_workspace_id = azurerm_synapse_workspace.synapse.id
  sku_name            = "DW100c"
  create_mode         = "Default"
}

# Azure Data Factory
resource "azurerm_data_factory" "adf" {
  name                = var.data_factory_name
  location            = azurerm_resource_group.dw_rg.location
  resource_group_name = azurerm_resource_group.dw_rg.name

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Azure SQL Database (for operational data)
resource "azurerm_sql_server" "sqlserver" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.dw_rg.name
  location                     = azurerm_resource_group.dw_rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password

  tags = var.tags
}

resource "azurerm_sql_database" "sqldb" {
  name                = var.sql_database_name
  resource_group_name = azurerm_resource_group.dw_rg.name
  location            = azurerm_resource_group.dw_rg.location
  server_name         = azurerm_sql_server.sqlserver.name
  edition             = "Standard"
} 