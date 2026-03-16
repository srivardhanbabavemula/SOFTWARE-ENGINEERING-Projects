# Power BI Connection Guide for Azure Synapse Analytics

## Prerequisites
1. Power BI Desktop installed
2. Access to Azure Synapse Analytics workspace
3. Azure AD account with appropriate permissions

## Connection Steps

### 1. Connect to Azure Synapse Analytics
1. Open Power BI Desktop
2. Click "Get Data"
3. Select "Azure" → "Azure Synapse Analytics (SQL DW)"
4. Enter the server name: `[workspace-name].sql.azuresynapse.net`
5. Select "DirectQuery" as the connection mode
6. Click "OK"

### 2. Authentication
1. Select "Microsoft Account" authentication
2. Sign in with your Azure AD credentials
3. Click "Connect"

### 3. Select Tables
1. In the Navigator window, select the following tables:
   - DimCustomer
   - DimDate
   - DimProduct
   - FactSales
2. Click "Load"

### 4. Create Relationships
1. Go to "Model" view
2. Create the following relationships:
   - FactSales[CustomerKey] → DimCustomer[CustomerKey]
   - FactSales[OrderDateKey] → DimDate[DateKey]
   - FactSales[ProductKey] → DimProduct[ProductKey]

### 5. Create Measures
```dax
Total Sales = SUM(FactSales[SalesAmount])
Total Quantity = SUM(FactSales[Quantity])
Average Order Value = DIVIDE([Total Sales], DISTINCTCOUNT(FactSales[OrderNumber]))
```

### 6. Publish to Power BI Service
1. Click "Publish"
2. Select your workspace
3. Click "Select"

## Best Practices
1. Use DirectQuery for real-time data
2. Create appropriate relationships
3. Use measures instead of calculated columns where possible
4. Implement row-level security if needed
5. Schedule refresh if using Import mode

## Row-Level Security Example
```dax
[Country Access] = 
VAR UserCountry = USERNAME()
RETURN
    CALCULATE(
        COUNTROWS(DimCustomer),
        DimCustomer[Country] = UserCountry
    )
```

## Performance Optimization
1. Use appropriate data types
2. Create indexes on frequently used columns
3. Use columnstore indexes for large tables
4. Implement partitioning for large fact tables
5. Use materialized views for complex calculations 