DROP TABLE IF EXISTS permits_marion_co;
CREATE TABLE permits_marion_co (
	id INT AUTO_INCREMENT PRIMARY KEY,
    permit_no VARCHAR(60) NOT NULL,
    permit_status VARCHAR(60),
    permit_type VARCHAR(60),
    permit_jurisdiction VARCHAR(30),
    permit_address VARCHAR(120),
    start_date DATE NOT NULL,
    expiration_date DATE NOT NULL
);

LOAD DATA INFILE 'C:/repos/RecordList20250123MARION_CO.csv'
INTO TABLE permits_marion_co
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(permit_no, permit_status, permit_type, permit_jurisdiction, permit_address, @start_date, @expiration_date)
SET
    start_date = STR_TO_DATE(@start_date, '%m/%d/%Y'),
    expiration_date = STR_TO_DATE(@expiration_date, '%m/%d/%Y');


-- SHOW variables like 'secure_file_priv';
-- SHOW VARIABLES LIKE 'local_infile';

-- SET GLOBAL local_infile = 'ON';

SELECT MONTH(start_date), count(*) as freq 
FROM permits_deschutes_co
GROUP BY MONTH(start_date)
ORDER BY MONTH(start_date);

select * from permits_marion_co order by start_date;

DROP TABLE IF EXISTS permits_deschutes_co;
CREATE TABLE permits_deschutes_co (
	id INT AUTO_INCREMENT PRIMARY KEY,
    permit_no VARCHAR(60) NOT NULL,
    permit_status VARCHAR(60),
    permit_type VARCHAR(60),
    permit_jurisdiction VARCHAR(30),
    permit_address VARCHAR(120),
    start_date DATE NOT NULL,
    expiration_date DATE NOT NULL
);

LOAD DATA INFILE 'C:/repos/RecordList20250126DESCHUTES_CO.csv'
INTO TABLE permits_deschutes_co
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(permit_no, permit_status, permit_type, permit_jurisdiction, permit_address, @start_date, @expiration_date)
SET
    start_date = STR_TO_DATE(@start_date, '%m/%d/%Y'),
    expiration_date = STR_TO_DATE(@expiration_date, '%m/%d/%Y');





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
