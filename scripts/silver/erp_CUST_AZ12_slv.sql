INSERT INTO silver.erp_CUST_AZ12 (
 cid,
 bdate,
 gen
)
SELECT
 CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, len(cid))
      ELSE cid
 END cid,
 CASE WHEN bdate > GETDATE() THEN NULL
      ELSE bdate
 END AS bdate,
 CASE WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
      WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
      ELSE 'n/a'
 END AS gen
FROM bronze.erp_CUST_AZ12
--WHERE cid LIKE '%AW00011000';


select bdate
from bronze.erp_CUST_AZ12
where bdate < '1924-01-01' or bdate > GETDATE()
