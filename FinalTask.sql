CREATE DATABASE DWH_Project

CREATE TABLE DimProduct (
	product_id VARCHAR(50) PRIMARY KEY NOT NULL,
	product_name VARCHAR(255) NOT NULL,
	product_unit_price INT NOT NULL
);

CREATE TABLE DimStatusOrder (
	status_id INT PRIMARY KEY NOT NULL,
	status_order VARCHAR(50) NOT NULL,
	status_order_desc VARCHAR(50) NOT NULL
);

CREATE TABLE DimCustomer (
	customer_id INT PRIMARY KEY NOT NULL,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	customerName varchar(50) NOT NULL	,
	age INT NOT NULL,
	gender varchar(50) NOT NULL,
	city varchar(50) NOT NULL,
	no_hp varchar(50) NOT NULL
);

CREATE TABLE FactSales (
	order_id INT PRIMARY KEY NOT NULL,
	customer_id INT NOT NULL,
	product_id VARCHAR(50) NOT NULL,
	quantity INT NOT NULL,
	amount INT NOT NULL,
	status_id INT NOT NULL,
	order_date DATE NOT NULL
	CONSTRAINT FK_SalesProduct FOREIGN KEY (product_id)
	REFERENCES DimProduct (product_id),
	CONSTRAINT FK_SalesCustomer FOREIGN KEY (customer_id)
	REFERENCES DimCustomer (customer_id),
	CONSTRAINT FK_SalesStatus FOREIGN KEY (status_id)
	REFERENCES DimStatusOrder (status_id)
);

ALTER TABLE DimCustomer
ADD customerName VARCHAR(50)

UPDATE DimCustomer
SET customerName = CONCAT(UPPER(first_name), ' ', UPPER(last_name))


CREATE PROCEDURE summary_order_status
(@status_id int) AS
BEGIN
    SELECT
        fs.order_id,
        dc.customerName,
        dp.productName,
        fs.quantity,
        dso.status_order
    FROM
        FactSales fs
    INNER JOIN
        DimCustomer dc ON fs.customer_id = dc.customer_id
    INNER JOIN
        DimProduct dp ON fs.product_id = dp.product_id
    INNER JOIN
        DimStatusOrder dso ON fs.status_id = dso.status_id
    WHERE
        dso.status_id = @status_id;
END 

EXEC summary_order_status @status_id = 2

DROP PROCEDURE summary_order_status

USE DWH_Project



DROP TABLE DimCustomer

SELECT * FROM DimStatusOrder






