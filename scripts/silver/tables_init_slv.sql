---DDL SCRIPT FOR SILVER LAYER---


--DDL statements for silver layer tables--
--!! Executing this script result in complete 
-- re-redefining of next tables:  
if object_id ('silver.crm_cust_info', 'U') IS NOT NULL
   DROP TABLE silver.crm_cust_info


create table silver.crm_cust_info (
 cst_id INT,
 cst_key NVARCHAR(50),
 cst_firstname NVARCHAR(50),
 cst_lastname NVARCHAR(50),
 cst_marital_status NVARCHAR(50),
 cst_gndr NVARCHAR(50),
 cst_create_date DATE,
 dwh_create_date DATETIME2 DEFAULT GETDATE()
);

if object_id ('silver.crm_pdr_info', 'U') IS NOT NULL
   DROP TABLE silver.crm_pdr_info
create table silver.crm_pdr_info (
 prd_id INT,
 prd_key NVARCHAR(50),
 prd_nm NVARCHAR(50),
 prd_cost NVARCHAR(50),
 prd_line NVARCHAR(50),
 prd_start_dt DATE,
 prd_end_dt DATE,
 dwh_create_date DATETIME2 DEFAULT GETDATE()
);

if object_id ('silver.crm_sales_details', 'U') IS NOT NULL
   DROP TABLE silver.crm_sales_details
create table silver.crm_sales_details (
 sls_ord_num NVARCHAR(50),
 sls_prd_key NVARCHAR(50),
 sls_cust_id int,
 sls_order_dt NVARCHAR(50),
 sls_ship_dt date,
 sls_due_dt date,
 sls_sales int,
 sls_quantity int,
 sls_price int,
 dwh_create_date DATETIME2 DEFAULT GETDATE()
);

if object_id ('silver.erp_CUST_AZ12', 'U') IS NOT NULL
   DROP TABLE silver.erp_CUST_AZ12
create table silver.erp_CUST_AZ12 (
 CID NVARCHAR(50),
 BDATE date,
 GEN NVARCHAR(50),
 dwh_create_date DATETIME2 DEFAULT GETDATE()
);

if object_id ('silver.erp_LOC_A101', 'U') IS NOT NULL
   DROP TABLE silver.erp_LOC_A101
create table silver.erp_LOC_A101 (
  CID NVARCHAR(50),
  CNTRY NVARCHAR(50),
  dwh_create_date DATETIME2 DEFAULT GETDATE()
);

if object_id ('silver.erp_PX_CAT_G1V2', 'U') IS NOT NULL
   DROP TABLE silver.erp_PX_CAT_G1V2
create table silver.erp_PX_CAT_G1V2(
  ID NVARCHAR(50),
  CAT NVARCHAR(50),
  SUBCAT NVARCHAR(50),
  MAINTENANCE NVARCHAR(50),
  dwh_create_date DATETIME2 DEFAULT GETDATE()
);
