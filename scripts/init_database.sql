/*
---------------------------------------------------------
CREATE DATABASE AND SCHEMAS
---------------------------------------------------------
Script Purpose:
	This script creates a new database 'DataWarehouse' after checking if it alredy exists.
    The script sets up three schemas withing the database: bronze, silver and gold
*/

DROP DATABASE IF EXISTS DataWarehouse;

-- Create the DataWarehouse Database
CREATE DATABASE DataWarehouse;
USE DataWarehouse;

-- Create the Schemas
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
