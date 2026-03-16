-- Create Sales Fact Table
CREATE TABLE [dbo].[FactSales]
(
    [SalesKey] [bigint] IDENTITY(1,1) NOT NULL,
    [OrderDateKey] [int] NOT NULL,
    [CustomerKey] [int] NOT NULL,
    [ProductKey] [int] NOT NULL,
    [OrderNumber] [nvarchar](20) NOT NULL,
    [OrderLineNumber] [int] NOT NULL,
    [Quantity] [int] NOT NULL,
    [UnitPrice] [decimal](18, 2) NOT NULL,
    [DiscountAmount] [decimal](18, 2) NOT NULL,
    [SalesAmount] [decimal](18, 2) NOT NULL,
    [TaxAmount] [decimal](18, 2) NOT NULL,
    [TotalAmount] [decimal](18, 2) NOT NULL,
    [CreatedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
    [ModifiedDate] [datetime] NULL,
    CONSTRAINT [PK_FactSales] PRIMARY KEY NONCLUSTERED ([SalesKey] ASC)
)
WITH
(
    DISTRIBUTION = HASH([OrderDateKey]),
    CLUSTERED COLUMNSTORE INDEX
);

-- Create Foreign Key Constraints
ALTER TABLE [dbo].[FactSales] WITH CHECK ADD CONSTRAINT [FK_FactSales_DimCustomer] 
FOREIGN KEY([CustomerKey]) REFERENCES [dbo].[DimCustomer] ([CustomerKey]);

ALTER TABLE [dbo].[FactSales] WITH CHECK ADD CONSTRAINT [FK_FactSales_DimDate] 
FOREIGN KEY([OrderDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);

ALTER TABLE [dbo].[FactSales] WITH CHECK ADD CONSTRAINT [FK_FactSales_DimProduct] 
FOREIGN KEY([ProductKey]) REFERENCES [dbo].[DimProduct] ([ProductKey]);

-- Create Indexes
CREATE NONCLUSTERED INDEX [IX_FactSales_OrderDateKey] ON [dbo].[FactSales]
(
    [OrderDateKey] ASC
)
INCLUDE ([SalesKey], [CustomerKey], [ProductKey], [SalesAmount]);

CREATE NONCLUSTERED INDEX [IX_FactSales_CustomerKey] ON [dbo].[FactSales]
(
    [CustomerKey] ASC
)
INCLUDE ([SalesKey], [OrderDateKey], [ProductKey], [SalesAmount]);

-- Create Statistics
CREATE STATISTICS [stat_FactSales_OrderDateKey] ON [dbo].[FactSales]([OrderDateKey]);
CREATE STATISTICS [stat_FactSales_CustomerKey] ON [dbo].[FactSales]([CustomerKey]);
CREATE STATISTICS [stat_FactSales_ProductKey] ON [dbo].[FactSales]([ProductKey]);
CREATE STATISTICS [stat_FactSales_SalesAmount] ON [dbo].[FactSales]([SalesAmount]); 