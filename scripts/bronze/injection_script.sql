--BULK LOADING BRONZE LAYER INTO DB--

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
		PRINT '========================================';
		PRINT 'Loading Bronze Layer, CRM source';
		PRINT '========================================';

		SET @start_time = GETDATE();
		PRINT '============bronze.crm_cust_info=============';
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\procjects\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		  FIRSTROW = 2,
		  FIELDTERMINATOR = ',',
		  TABLOCK
		);

		PRINT '============bronze.crm_pdr_info==============';
		TRUNCATE TABLE bronze.crm_pdr_info;
		BULK INSERT bronze.crm_pdr_info
		FROM 'C:\procjects\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		  FIRSTROW = 2,
		  FIELDTERMINATOR = ',',
		  TABLOCK
		);

		PRINT '===========bronze.crm_sales_details===============';
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\procjects\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		  FIRSTROW = 2,
		  FIELDTERMINATOR = ',',
		  TABLOCK
		);

		PRINT '========================================';
		PRINT 'Loading Bronze Layer, ERP source';
		PRINT '========================================';

		PRINT '=============bronze.erp_CUST_AZ12============';
		TRUNCATE TABLE bronze.erp_CUST_AZ12;
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'C:\procjects\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
		  FIRSTROW = 2,
		  FIELDTERMINATOR = ',',
		  TABLOCK
		);

		PRINT '==========bronze.erp_LOC_A101============';
		TRUNCATE TABLE bronze.erp_LOC_A101;
		BULK INSERT bronze.erp_LOC_A101
		FROM 'C:\procjects\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
		  FIRSTROW = 2,
		  FIELDTERMINATOR = ',',
		  TABLOCK
		);

		PRINT '==========bronze.erp_PX_CAT_G1V2=========';
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'C:\procjects\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
		  FIRSTROW = 2,
		  FIELDTERMINATOR = ',',
		  TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'LOAD DURATION: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'

	END TRY
	BEGIN CATCH
	    PRINT '==============================';
		PRINT 'ERROR DURING BRONZE LAYER LOADING';
		PRINT 'ERROR MESSAGE:' + ERROR_MESSAGE();
	END CATCH
END
