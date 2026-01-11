/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    DECLARE 
        @start_time DATETIME,
        @end_time   DATETIME,
        @batch_start_time DATETIME,
        @batch_end_time DATETIME;

    BEGIN TRY

        SET @batch_start_time = GETDATE();

        PRINT '===========================================';
        PRINT 'Loading Bronze Layer';
        PRINT '===========================================';

        PRINT '-------------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '-------------------------------------------';

        /* ================= CRM CUSTOMER INFO ================= */
        SET @start_time = GETDATE();

        PRINT '>> TRUNCATING bronze.crm_cust_info Table';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> INSERTING data into bronze.crm_cust_info Table';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\DELL\OneDrive\Desktop\SQL-Warehouse-Project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW        = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '-------------------';

        /* ================= CRM PRODUCT INFO ================= */
        SET @start_time = GETDATE();

        PRINT '>> TRUNCATING bronze.crm_prd_info Table';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> INSERTING data into bronze.crm_prd_info Table';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Users\DELL\OneDrive\Desktop\SQL-Warehouse-Project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW        = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '-------------------';

        /* ================= CRM SALES DETAILS ================= */
        SET @start_time = GETDATE();

        PRINT '>> TRUNCATING bronze.crm_sales_details Table';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> INSERTING data into bronze.crm_sales_details Table';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\DELL\OneDrive\Desktop\SQL-Warehouse-Project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW        = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '-------------------';

        /* ================= ERP TABLES ================= */
        PRINT '-------------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '-------------------------------------------';

        /* ================= ERP LOCATION ================= */
        SET @start_time = GETDATE();

        PRINT '>> TRUNCATING bronze.erp_loc_a101 Table';
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>> INSERTING data into bronze.erp_loc_a101 Table';
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Users\DELL\OneDrive\Desktop\SQL-Warehouse-Project\datasets\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW        = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '-------------------';

        /* ================= ERP CUSTOMER ================= */
        SET @start_time = GETDATE();

        PRINT '>> TRUNCATING bronze.erp_cust_az12 Table';
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>> INSERTING data into bronze.erp_cust_az12 Table';
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Users\DELL\OneDrive\Desktop\SQL-Warehouse-Project\datasets\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW        = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '-------------------';

        /* ================= ERP PRODUCT CATEGORY ================= */
        SET @start_time = GETDATE();

        PRINT '>> TRUNCATING bronze.erp_px_cat_g1v2 Table';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>> INSERTING data into bronze.erp_px_cat_g1v2 Table';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Users\DELL\OneDrive\Desktop\SQL-Warehouse-Project\datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW        = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT '>> Load Duration : ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + 'seconds';
        PRINT '-------------------';

        SET @batch_end_time = GETDATE();
        PRINT '==================='
        PRINT '>> Total Load Duration : ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
        PRINT '===================';

    END TRY
    BEGIN CATCH
        PRINT '===========================================';
        PRINT 'ERROR MESSAGE : ' + ERROR_MESSAGE();
        PRINT 'ERROR NUMBER  : ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'ERROR STATE   : ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '===========================================';
    END CATCH
END;
