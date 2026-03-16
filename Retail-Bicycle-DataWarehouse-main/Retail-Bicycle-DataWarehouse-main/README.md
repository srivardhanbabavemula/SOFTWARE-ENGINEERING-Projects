# 🚴‍♂️ Retail Bicycle Data Warehouse & BI Dashboard

This project demonstrates the design and implementation of a **Retail Bicycle Data Warehouse** that provides actionable insights into sales, shipments, purchases, and overall business performance for a retail bicycle company. The warehouse transforms raw operational data into clean, structured datasets and interactive dashboards for decision-making.

## 🧱 Architecture

The solution follows a **4-layer Teradata architecture**:

- **Layer 1 – Staging:** Raw data from multiple operational sources was loaded using **FastLoad scripts**.  
- **Layer 2 – Cleansing & Transformation:** Business rules, validations, and transformations were applied using **BTEQ** and **SQL**.  
- **Layer 3 – Reference Data Model (RDM):** Integrated and standardized key entities across Sales, HR, Purchasing, and Production.  
- **Layer 4 – Data Mart / Reporting:** Optimized **star schema** models were created for reporting and analytical queries.

**ETL Automation:**  
Shell scripts were developed to execute all BTEQ jobs sequentially, with logging and error handling to ensure smooth and repeatable data loading across all layers.

## 🧠 BI Dashboards & Outputs

Interactive dashboards were built in **Power BI** and **Tableau** to visualize business performance:

### 📊 Key Outputs & Insights

1. **Executive Summary**  
   - Overall sales performance and trends  
   - Key metrics and KPIs for a quick business overview  

2. **Shipment Analysis**  
   - Total order amounts  
   - Number of orders shipped  
   - Monthly shipment trends and comparisons  

3. **What-If Analysis**  
   - Actual vs Commissioned sales  
   - Scenario-based insights for sales planning and forecasting  

4. **Purchase Analysis**  
   - **Vendor vs Ship Method Analysis Matrix** to track supplier efficiency  
   - **Received vs Rejected Quantity by Vendor** for quality and inventory monitoring  

Dashboards support **interactive filtering** by product, region, vendor, or date to explore detailed insights efficiently.

## 🛠 Technologies Used
Teradata | SQL | FastLoad | BTEQ | Shell Scripting | Power BI | ETL | Data Modeling | Star Schema Design


## 📧 Contact
Abdul Wahab
