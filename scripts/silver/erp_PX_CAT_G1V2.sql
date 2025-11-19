insert into silver.erp_PX_CAT_G1V2 (
 id,
 cat,
 subcat,
 maintenance
)
select 
 id,
 cat,
 subcat,
 maintenance
from silver.erp_PX_CAT_G1V2;


SELECT DISTINCT maintenance from bronze.erp_PX_CAT_G1V2;
