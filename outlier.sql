-- Create sales_order table
CREATE TABLE sales_order (
    entity_id SERIAL PRIMARY KEY,
    increment_id VARCHAR(50) NOT NULL,
    sap_order_id BIGINT NOT NULL
);

-- Create sales_order_address table
CREATE TABLE sales_order_address (
    entity_id SERIAL PRIMARY KEY,
    customer_address_id INT,
    quote_address_id INT,
    parent_id INT REFERENCES sales_order(entity_id),
    customer_id INT,
    firstname VARCHAR(100),
    lastname VARCHAR(100),
    email VARCHAR(100),
    company VARCHAR(100),
    street VARCHAR(255),
    city VARCHAR(100),
    postcode VARCHAR(20),
    region VARCHAR(100),
    address_type VARCHAR(20) CHECK (address_type IN ('billing', 'shipping')) NOT NULL,
    sap_id_for_address VARCHAR(50)
);

-- Insert data into sales_order
INSERT INTO sales_order (increment_id, sap_order_id) 
VALUES 
    ('10000001', 3901470321),
    ('10000002', 3901453410),
    ('10000003', 3901451160),
    ('10000004', 3901417134),
    ('10000005', 3901430685),
    ('10000006', 3901405743),
    ('10000007', 3901400153),
    ('10000008', 3901393494),
    ('10000009', 3901366009);

-- Insert data into sales_order_address
INSERT INTO sales_order_address (customer_address_id, quote_address_id, parent_id, customer_id, firstname, lastname, email, company, street, city, postcode, region, address_type, sap_id_for_address) 
VALUES 
    (1, 1, 1, 1, 'John', 'Doe', 'john.doe@example.com', 'Company A', '123 Main St', 'City A', '12345', 'Region A', 'billing', 'SAP001'),
    (2, 2, 2, 2, 'Jane', 'Smith', 'jane.smith@example.com', 'Company B', '456 Elm St', 'City B', '54321', 'Region B', 'shipping', 'SAP002'),
    (3, 3, 3, 3, 'Alice', 'Johnson', 'alice.johnson@example.com', 'Company C', '789 Pine St', 'City C', '67890', 'Region C', 'shipping', 'SAP003'),
    (4, 4, 4, 4, 'Bob', 'Brown', 'bob.brown@example.com', 'Company D', '321 Oak St', 'City D', '09876', 'Region D', 'shipping', 'SAP004'),
    (5, 5, 5, 5, 'Charlie', 'Davis', 'charlie.davis@example.com', 'Company E', '654 Maple St', 'City E', '13579', 'Region E', 'shipping', 'SAP005'),
    (6, 6, 6, 6, 'Eva', 'Green', 'eva.green@example.com', 'Company F', '987 Cedar St', 'City F', '97531', 'Region F', 'shipping', 'SAP006'),
    (7, 7, 7, 7, 'Dan', 'Wilson', 'dan.wilson@example.com', 'Company G', '234 Birch St', 'City G', '24680', 'Region G', 'shipping', 'SAP007'),
    (8, 8, 8, 8, 'Grace', 'Taylor', 'grace.taylor@example.com', 'Company H', '135 Willow St', 'City H', '86420', 'Region H', 'shipping', 'SAP008'),
    (9, 9, 9, 9, 'Henry', 'Harris', 'henry.harris@example.com', 'Company I', '543 Ash St', 'City I', '12321', 'Region I', 'shipping', 'SAP009');

-- Update records
UPDATE sales_order_address
SET 
    company = CASE entity_id
        WHEN 1 THEN 'ACE'
        WHEN 6 THEN 'Ifinity'
        WHEN 7 THEN 'LT Telephone'
        WHEN 8 THEN 'Broadway LLC'
        WHEN 9 THEN 'EC Cleveland' END,
    firstname = CASE entity_id
        WHEN 1 THEN 'Aden'
        WHEN 6 THEN 'Ian'
        WHEN 7 THEN 'Lucy'
        WHEN 8 THEN 'Ben'
        WHEN 9 THEN 'Victor' END,
    lastname = CASE entity_id
        WHEN 1 THEN 'Macmillan'
        WHEN 6 THEN 'Lee'
        WHEN 7 THEN 'Huff'
        WHEN 8 THEN 'Trusty'
        WHEN 9 THEN 'Belford' END,
    street = CASE entity_id
        WHEN 1 THEN '900 Locust Rd'
        WHEN 6 THEN '55 Eagles Flight Ln'
        WHEN 7 THEN '1111 Wide Street'
        WHEN 8 THEN '8603 W. 100 N.'
        WHEN 9 THEN '6364 Georgetown RD NW' END,
    city = CASE entity_id
        WHEN 1 THEN 'Lenexa'
        WHEN 6 THEN 'Kinston'
        WHEN 7 THEN 'Loretto'
        WHEN 8 THEN 'Peru'
        WHEN 9 THEN 'Cleveland' END,
    postcode = CASE entity_id
        WHEN 1 THEN '66215'
        WHEN 6 THEN '28504'
        WHEN 7 THEN '38469'
        WHEN 8 THEN '46970'
        WHEN 9 THEN '37312-1317' END
WHERE entity_id IN (1, 6, 7, 8, 9);

-- Select data
SELECT soa.entity_id, soa.customer_address_id, so.sap_order_id  
FROM sales_order_address soa
JOIN sales_order so ON soa.parent_id = so.entity_id;
