
SELECT
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

SELECT prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

SELECT prd_cost
  FROM silver.crm_prd_info
 WHERE prd_cost < 0 OR prd_cost is null;


 select distinct prd_line
 from silver.crm_prd_info;

 SELECT *
 FROM silver.crm_prd_info
 WHERE prd_end_dt < prd_start_dt

 SELECT * 
 FROM silver.crm_prd_info

 select prd_id,
        prd_key,
        prd_nm,
        prd_cost,
        prd_line,
        prd_start_dt,
        prd_end_dt,
        DATEADD(day, -1, LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)) AS prd_end_dt_test
 from bronze.crm_pdr_info
 where prd_key IN ('AC-HE-HL-U509-R', 'AC-HE-HL-U509');


 --bronze.crm_pdr_info CLEANSING AND INSERTING--
INSERT INTO silver.crm_prd_info (
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
 )
select 
prd_id,
--prd_key,
REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') as cat_id,
SUBSTRING(prd_key, 7, LEN(prd_key)) as prd_key,
prd_nm,
ISNULL(prd_cost, 0) as prd_cost,
--prd_line,
CASE UPPER(TRIM(prd_line)) 
     WHEN 'M' THEN 'Mountain'
     WHEN 'R' THEN 'Road'
     WHEN 'S' THEN 'other Sales'
     WHEN 'T' THEN 'Touring'
     ELSE 'n/a'
END AS prd_line,
CAST(prd_start_dt AS DATE) AS prd_start_dt,
CAST(DATEADD(day, -1, LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt)) AS DATE) AS prd_end_dt
from bronze.crm_pdr_info
where SUBSTRING(prd_key, 7, LEN(prd_key)) in
 (select sls_prd_key from bronze.crm_sales_details);
