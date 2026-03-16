variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "dw-modernization-rg"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "Production"
    Project     = "DataWarehouse"
  }
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "datalakestorage"
}

variable "synapse_workspace_name" {
  description = "Name of the Synapse workspace"
  type        = string
  default     = "synapse-workspace"
}

variable "synapse_sql_pool_name" {
  description = "Name of the Synapse SQL pool"
  type        = string
  default     = "sqlpool"
}

variable "synapse_sql_admin_username" {
  description = "SQL administrator username for Synapse"
  type        = string
  default     = "sqladmin"
}

variable "synapse_sql_admin_password" {
  description = "SQL administrator password for Synapse"
  type        = string
  sensitive   = true
}

variable "data_factory_name" {
  description = "Name of the Data Factory"
  type        = string
  default     = "adf-dw-modernization"
}

variable "sql_server_name" {
  description = "Name of the SQL Server"
  type        = string
  default     = "sqlserver-dw"
}

variable "sql_database_name" {
  description = "Name of the SQL Database"
  type        = string
  default     = "sqldb-dw"
}

variable "sql_admin_username" {
  description = "SQL administrator username"
  type        = string
  default     = "sqladmin"
}

variable "sql_admin_password" {
  description = "SQL administrator password"
  type        = string
  sensitive   = true
} 