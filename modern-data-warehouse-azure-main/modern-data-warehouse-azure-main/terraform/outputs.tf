output "synapse_workspace_id" {
  description = "ID of the Synapse workspace"
  value       = azurerm_synapse_workspace.synapse.id
}

output "synapse_sql_pool_id" {
  description = "ID of the Synapse SQL pool"
  value       = azurerm_synapse_sql_pool.sqlpool.id
}

output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.datalake.id
}

output "data_factory_id" {
  description = "ID of the Data Factory"
  value       = azurerm_data_factory.adf.id
}

output "sql_server_id" {
  description = "ID of the SQL Server"
  value       = azurerm_sql_server.sqlserver.id
}

output "sql_database_id" {
  description = "ID of the SQL Database"
  value       = azurerm_sql_database.sqldb.id
} 