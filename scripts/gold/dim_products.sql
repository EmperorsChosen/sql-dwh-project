--CHECK FOR UNICALITY
SELECT prd_id, COUNT(*) FROM(
SELECT
     pn.prd_id,
     pn.cat_id,
     pn.prd_key,
     pn.prd_nm,
     pn.prd_cost,
     pn.prd_line,
     pn.prd_start_dt,
     pn.prd_end_dt,
     pc.CAT,
     pc.SUBCAT,
     pc.MAINTENANCE
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_PX_CAT_G1V2 pc
       ON pn.cat_id = pc.ID
WHERE pn.prd_end_dt IS NULL -- clear all entries of old rpices
) t GROUP BY prd_id
HAVING COUNT(*) > 1;
--CHECK END

CREATE VIEW gold.dim_products AS 
SELECT
     ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,
     pn.prd_id AS product_id,
     pn.prd_key AS product_number,
     pn.prd_nm AS product_name,
     pn.cat_id AS category_id,
     pc.CAT AS category,
     pc.SUBCAT AS subcategory,
     pc.MAINTENANCE,
     pn.prd_cost AS cost,
     pn.prd_line AS product_line,
     pn.prd_start_dt AS start_date
     --pn.prd_end_dt
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_PX_CAT_G1V2 pc
       ON pn.cat_id = pc.ID
WHERE pn.prd_end_dt IS NULL -- clear all entries of old rpices

---

SELECT * FROM gold.dim_products
