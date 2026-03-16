# Azure-Based Enterprise Data Warehouse Modernization

## Overview
This project implements a modern cloud-native data warehouse solution using Azure services, migrating from legacy on-prem SQL Server to a scalable, secure, and performant architecture.

## Architecture

```mermaid
graph TB
    subgraph "Source Systems"
        A1[On-Prem SQL Server]
        A2[Azure SQL Database]
    end

    subgraph "Data Ingestion"
        B1[Azure Data Factory]
        B2[Data Lake Gen2]
        B3[Raw Zone]
        B4[Curated Zone]
    end

    subgraph "Data Warehouse"
        C1[Azure Synapse Analytics]
        C2[SQL Pool]
        C3[Dimension Tables]
        C4[Fact Tables]
    end

    subgraph "Analytics & Visualization"
        D1[Power BI]
        D2[DirectQuery]
        D3[Dashboards]
    end

    subgraph "Security & Governance"
        E1[Azure AD]
        E2[RBAC]
        E3[Row-Level Security]
    end

    A1 --> B1
    A2 --> B1
    B1 --> B2
    B2 --> B3
    B3 --> B4
    B4 --> C1
    C1 --> C2
    C2 --> C3
    C2 --> C4
    C1 --> D1
    D1 --> D2
    D2 --> D3
    E1 --> E2
    E2 --> E3
    E3 --> C1
    E3 --> D1
```

## Key Components

### 1. Data Ingestion Layer
- **Azure Data Factory (ADF)**
  - Orchestrates ETL/ELT processes
  - Handles data movement and transformation
  - Supports multiple source systems
  - Implements data quality checks

### 2. Data Storage Layer
- **Azure Data Lake Gen2**
  - Raw zone for landing data
  - Curated zone for transformed data
  - Hierarchical namespace support
  - Cost-effective storage tiers

### 3. Data Warehouse Layer
- **Azure Synapse Analytics**
  - Dedicated SQL pool for analytics
  - Star/snowflake schema implementation
  - Optimized for query performance
  - Built-in workload management

### 4. Analytics & Visualization
- **Power BI**
  - DirectQuery for real-time analytics
  - Interactive dashboards
  - Row-level security
  - Scheduled refreshes

### 5. Security & Governance
- **Azure AD Integration**
  - Role-based access control (RBAC)
  - Row-level security
  - Audit logging
  - Data encryption

## Prerequisites

### Azure Requirements
- Active Azure subscription
- Contributor access to create resources
- Azure AD tenant for authentication

### Tools Required
- Azure CLI
- Terraform
- Power BI Desktop
- SQL Server Management Studio (optional)

## Deployment

### 1. Infrastructure Setup
```bash
# Initialize Terraform
cd terraform
terraform init

# Apply infrastructure
terraform apply -auto-approve
```

### 2. Data Pipeline Configuration
1. Deploy ADF pipeline from `adf/pipelines/etl_pipeline.json`
2. Configure source and sink connections
3. Set up pipeline triggers

### 3. Data Warehouse Setup
1. Execute SQL scripts in `synapse/sql/`
2. Create dimension and fact tables
3. Set up indexes and statistics

### 4. Power BI Integration
1. Follow `powerbi/connection_guide.md`
2. Create data model
3. Implement security rules
4. Publish dashboards

## Directory Structure
```
azure-dw-modernization/
├── terraform/               # Infrastructure as Code
│   ├── main.tf             # Main Terraform configuration
│   ├── variables.tf        # Variable definitions
│   └── outputs.tf          # Output definitions
├── adf/                    # Azure Data Factory
│   └── pipelines/          # Pipeline definitions
│       └── etl_pipeline.json
├── synapse/               # Synapse Analytics
│   └── sql/              # SQL scripts
│       ├── dim_customer.sql
│       └── fact_sales.sql
├── powerbi/              # Power BI
│   └── connection_guide.md
└── README.md
```

## Monitoring & Maintenance

### Performance Monitoring
- Use Synapse Studio for query performance
- Monitor ADF pipeline runs
- Track Power BI refresh times
- Set up Azure Monitor alerts

### Cost Optimization
- Right-size Synapse SQL pool
- Implement data lifecycle management
- Use appropriate storage tiers
- Monitor resource utilization

### Security Maintenance
- Regular access reviews
- Update security policies
- Monitor audit logs
- Rotate credentials

## Clean Up
```bash
# Destroy infrastructure
cd terraform
terraform destroy -auto-approve
```

## Contributing
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License
MIT License - See LICENSE file for details

