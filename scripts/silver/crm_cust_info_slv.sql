--selection of corrupted id records--
SELECT cci.cst_id,
       COUNT(*)
FROM bronze.crm_cust_info cci
GROUP BY cci.cst_id
HAVING COUNT(*) > 1 OR cci.cst_id IS NULL;

--selection of only last record for each ID
SELECT *
FROM(
    SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY cci.cst_id ORDER BY cci.cst_create_date DESC) as flag_last
    FROM bronze.crm_cust_info cci 
    --WHERE cci.cst_id = 29466 
) t 
WHERE flag_last = 1

--select for checking unwanted spaces in varchar--
SELECT DISTINCT 
       cst_marital_status,
       cst_gndr
  FROM bronze.crm_cust_info


INSERT INTO silver.crm_cust_info (cst_id, 
                                  cst_key,
                                  cst_firstname,
                                  cst_lastname,
                                  cst_marital_status,
                                  cst_gndr,
                                  cst_create_date
                                  )


SELECT *
FROM(
    SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY cci.cst_id ORDER BY cci.cst_create_date DESC) as flag_last
    FROM silver.crm_cust_info cci 
    --WHERE cci.cst_id = 29466 
) t 
WHERE flag_last != 1

--bronze.crm_cust_info СLEANSING--
SELECT 
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,
CASE WHEN UPPER(cst_marital_status) = 'M' THEN 'Married'
     WHEN UPPER(cst_marital_status) = 'F' THEN 'Single'
     ELSE 'n/a'
END cst_marital_status,
CASE WHEN UPPER(cst_gndr) = 'M' THEN 'Male'
     WHEN UPPER(cst_gndr) = 'F' THEN 'Female'
     ELSE 'n/a'
END cst_gndr,
cst_create_date
FROM(
    SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY cci.cst_id ORDER BY cci.cst_create_date DESC) as flag_last
    FROM bronze.crm_cust_info cci 
    --WHERE cci.cst_id = 29466 
) t WHERE flag_last = 1
