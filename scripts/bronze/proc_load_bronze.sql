DELIMITER $$

CREATE PROCEDURE load_bronze()
BEGIN
    -- Declare variables for tracking duration
    DECLARE v_start_time DATETIME;
    DECLARE v_end_time DATETIME;
    DECLARE v_batch_start_time DATETIME;
    DECLARE v_batch_end_time DATETIME;

    -- Error handler for CATCH block equivalent
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 
            @sqlstate = RETURNED_SQLSTATE, 
            @errno = MYSQL_ERRNO, 
            @text = MESSAGE_TEXT;
            
        SELECT '==========================================';
        SELECT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
        SELECT CONCAT('Error Message: ', @text);
        SELECT CONCAT('Error Number: ', @errno);
        SELECT CONCAT('SQL State: ', @sqlstate);
        SELECT '==========================================';
    END;

    SET v_batch_start_time = NOW();
    
    SELECT '================================================';
    SELECT 'Loading Bronze Layer';
    SELECT '================================================';

    SELECT '------------------------------------------------';
    SELECT 'Loading CRM Tables';
    SELECT '------------------------------------------------';

    -- 1. Load bronze.crm_cust_info
    SET v_start_time = NOW();
    SELECT '>> Truncating Table: bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;
    
    SELECT '>> Inserting Data Into: bronze.crm_cust_info';
    SET @sql = CONCAT(
        "LOAD DATA INFILE 'C:/sql/dwh_project/datasets/source_crm/cust_info.csv' ",
        "INTO TABLE bronze.crm_cust_info ",
        "FIELDS TERMINATED BY ',' ",
        "ENCLOSED BY '\"' ",
        "LINES TERMINATED BY '\n' ",
        "IGNORE 1 LINES;"
    );
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    SET v_end_time = NOW();
    SELECT CONCAT('>> Load Duration: ', TIMESTAMPDIFF(SECOND, v_start_time, v_end_time), ' seconds');
    SELECT '>> -------------';

    -- 2. Load bronze.crm_prd_info
    SET v_start_time = NOW();
    SELECT '>> Truncating Table: bronze.crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;
    
    SELECT '>> Inserting Data Into: bronze.crm_prd_info';
    SET @sql = CONCAT(
        "LOAD DATA INFILE 'C:/sql/dwh_project/datasets/source_crm/prd_info.csv' ",
        "INTO TABLE bronze.crm_prd_info ",
        "FIELDS TERMINATED BY ',' ",
        "ENCLOSED BY '\"' ",
        "LINES TERMINATED BY '\n' ",
        "IGNORE 1 LINES;"
    );
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    SET v_end_time = NOW();
    SELECT CONCAT('>> Load Duration: ', TIMESTAMPDIFF(SECOND, v_start_time, v_end_time), ' seconds');
    SELECT '>> -------------';

    -- 3. Load bronze.crm_sales_details
    SET v_start_time = NOW();
    SELECT '>> Truncating Table: bronze.crm_sales_details';
    TRUNCATE TABLE bronze.crm_sales_details;
    
    SELECT '>> Inserting Data Into: bronze.crm_sales_details';
    SET @sql = CONCAT(
        "LOAD DATA INFILE 'C:/sql/dwh_project/datasets/source_crm/sales_details.csv' ",
        "INTO TABLE bronze.crm_sales_details ",
        "FIELDS TERMINATED BY ',' ",
        "ENCLOSED BY '\"' ",
        "LINES TERMINATED BY '\n' ",
        "IGNORE 1 LINES;"
    );
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    SET v_end_time = NOW();
    SELECT CONCAT('>> Load Duration: ', TIMESTAMPDIFF(SECOND, v_start_time, v_end_time), ' seconds');
    SELECT '>> -------------';

    SELECT '------------------------------------------------';
    SELECT 'Loading ERP Tables';
    SELECT '------------------------------------------------';

    -- 4. Load bronze.erp_loc_a101
    SET v_start_time = NOW();
    SELECT '>> Truncating Table: bronze.erp_loc_a101';
    TRUNCATE TABLE bronze.erp_loc_a101;
    
    SELECT '>> Inserting Data Into: bronze.erp_loc_a101';
    SET @sql = CONCAT(
        "LOAD DATA INFILE 'C:/sql/dwh_project/datasets/source_erp/loc_a101.csv' ",
        "INTO TABLE bronze.erp_loc_a101 ",
        "FIELDS TERMINATED BY ',' ",
        "ENCLOSED BY '\"' ",
        "LINES TERMINATED BY '\n' ",
        "IGNORE 1 LINES;"
    );
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    SET v_end_time = NOW();
    SELECT CONCAT('>> Load Duration: ', TIMESTAMPDIFF(SECOND, v_start_time, v_end_time), ' seconds');
    SELECT '>> -------------';

    -- 5. Load bronze.erp_cust_az12
    SET v_start_time = NOW();
    SELECT '>> Truncating Table: bronze.erp_cust_az12';
    TRUNCATE TABLE bronze.erp_cust_az12;
    
    SELECT '>> Inserting Data Into: bronze.erp_cust_az12';
    SET @sql = CONCAT(
        "LOAD DATA INFILE 'C:/sql/dwh_project/datasets/source_erp/cust_az12.csv' ",
        "INTO TABLE bronze.erp_cust_az12 ",
        "FIELDS TERMINATED BY ',' ",
        "ENCLOSED BY '\"' ",
        "LINES TERMINATED BY '\n' ",
        "IGNORE 1 LINES;"
    );
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    SET v_end_time = NOW();
    SELECT CONCAT('>> Load Duration: ', TIMESTAMPDIFF(SECOND, v_start_time, v_end_time), ' seconds');
    SELECT '>> -------------';

    -- 6. Load bronze.erp_px_cat_g1v2
    SET v_start_time = NOW();
    SELECT '>> Truncating Table: bronze.erp_px_cat_g1v2';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    
    SELECT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
    SET @sql = CONCAT(
        "LOAD DATA INFILE 'C:/sql/dwh_project/datasets/source_erp/px_cat_g1v2.csv' ",
        "INTO TABLE bronze.erp_px_cat_g1v2 ",
        "FIELDS TERMINATED BY ',' ",
        "ENCLOSED BY '\"' ",
        "LINES TERMINATED BY '\n' ",
        "IGNORE 1 LINES;"
    );
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    SET v_end_time = NOW();
    SELECT CONCAT('>> Load Duration: ', TIMESTAMPDIFF(SECOND, v_start_time, v_end_time), ' seconds');
    SELECT '>> -------------';

    SET v_batch_end_time = NOW();
    SELECT '==========================================';
    SELECT 'Loading Bronze Layer is Completed';
    SELECT CONCAT('    - Total Load Duration: ', TIMESTAMPDIFF(SECOND, v_batch_start_time, v_batch_end_time), ' seconds');
    SELECT '==========================================';

END$$

DELIMITER ;
