-- Drop/create table for all jurisdictions
DROP TABLE IF EXISTS permits_all_juris;
CREATE TABLE permits_all_juris (
	id INT AUTO_INCREMENT PRIMARY KEY,
    permit_no VARCHAR(60) NOT NULL,
    permit_status VARCHAR(60),
    permit_type VARCHAR(60),
    permit_jurisdiction VARCHAR(30),
    permit_address VARCHAR(120),
    start_date DATE NOT NULL,
    expiration_date DATE NOT NULL
);

-- Load deschutes county data
LOAD DATA INFILE 'C:/repos/RecordList20250126DESCHUTES_CO.csv'
INTO TABLE permits_all_juris
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(permit_no, permit_status, permit_type, permit_jurisdiction, permit_address, @start_date, @expiration_date)
SET
    start_date = STR_TO_DATE(@start_date, '%m/%d/%Y'),
    expiration_date = STR_TO_DATE(@expiration_date, '%m/%d/%Y');

-- Load marion county data
LOAD DATA INFILE 'C:/repos/RecordList20250123MARION_CO.csv'
INTO TABLE permits_all_juris
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(permit_no, permit_status, permit_type, permit_jurisdiction, permit_address, @start_date, @expiration_date)
SET
    start_date = STR_TO_DATE(@start_date, '%m/%d/%Y'),
    expiration_date = STR_TO_DATE(@expiration_date, '%m/%d/%Y');


-- Load lincoln county data
LOAD DATA INFILE 'C:/repos/RecordList20250126LINCOLN_CO.csv'
INTO TABLE permits_all_juris
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(permit_no, permit_status, permit_type, permit_jurisdiction, permit_address, @start_date, @expiration_date)
SET
    start_date = STR_TO_DATE(@start_date, '%m/%d/%Y'),
    expiration_date = STR_TO_DATE(@expiration_date, '%m/%d/%Y');
    

-- Load milw data
LOAD DATA INFILE 'C:/repos/RecordList20250126MILW.csv'
INTO TABLE permits_all_juris
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(permit_no, permit_status, permit_type, permit_jurisdiction, permit_address, @start_date, @expiration_date)
SET
    start_date = STR_TO_DATE(@start_date, '%m/%d/%Y'),
    expiration_date = STR_TO_DATE(@expiration_date, '%m/%d/%Y');
    
-- Load redmond data
LOAD DATA INFILE 'C:/repos/RecordList20250126REDMOND.csv'
INTO TABLE permits_all_juris
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(permit_no, permit_status, permit_type, permit_jurisdiction, permit_address, @start_date, @expiration_date)
SET
    start_date = STR_TO_DATE(@start_date, '%m/%d/%Y'),
    expiration_date = STR_TO_DATE(@expiration_date, '%m/%d/%Y');
    
-- Load springfield data
LOAD DATA INFILE 'C:/repos/RecordList20250126SPFD.csv'
INTO TABLE permits_all_juris
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(permit_no, permit_status, permit_type, permit_jurisdiction, permit_address, @start_date, @expiration_date)
SET
    start_date = STR_TO_DATE(@start_date, '%m/%d/%Y'),
    expiration_date = STR_TO_DATE(@expiration_date, '%m/%d/%Y');
    
