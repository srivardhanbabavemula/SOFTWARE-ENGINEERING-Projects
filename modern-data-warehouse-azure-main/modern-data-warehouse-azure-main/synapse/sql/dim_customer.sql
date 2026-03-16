-- Create Customer Dimension Table
CREATE TABLE [dbo].[DimCustomer]
(
    [CustomerKey] [int] IDENTITY(1,1) NOT NULL,
    [CustomerID] [int] NOT NULL,
    [CustomerName] [nvarchar](100) NOT NULL,
    [CustomerType] [nvarchar](50) NULL,
    [Address] [nvarchar](200) NULL,
    [City] [nvarchar](50) NULL,
    [State] [nvarchar](50) NULL,
    [Country] [nvarchar](50) NULL,
    [PostalCode] [nvarchar](20) NULL,
    [Phone] [nvarchar](20) NULL,
    [Email] [nvarchar](100) NULL,
    [StartDate] [datetime] NOT NULL,
    [EndDate] [datetime] NULL,
    [IsCurrent] [bit] NOT NULL,
    [CreatedDate] [datetime] NOT NULL DEFAULT (GETDATE()),
    [ModifiedDate] [datetime] NULL,
    CONSTRAINT [PK_DimCustomer] PRIMARY KEY CLUSTERED ([CustomerKey] ASC)
)
WITH
(
    DISTRIBUTION = HASH([CustomerID]),
    CLUSTERED COLUMNSTORE INDEX
);

-- Create Indexes
CREATE NONCLUSTERED INDEX [IX_DimCustomer_CustomerID] ON [dbo].[DimCustomer]
(
    [CustomerID] ASC
)
INCLUDE ([CustomerKey]);

-- Create Statistics
CREATE STATISTICS [stat_DimCustomer_CustomerID] ON [dbo].[DimCustomer]([CustomerID]);
CREATE STATISTICS [stat_DimCustomer_CustomerName] ON [dbo].[DimCustomer]([CustomerName]);
CREATE STATISTICS [stat_DimCustomer_Country] ON [dbo].[DimCustomer]([Country]); 