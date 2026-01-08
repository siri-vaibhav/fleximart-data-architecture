-- Insert into dim_date
INSERT INTO dim_date VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,FALSE),
(20240102,'2024-01-02','Tuesday',2,1,'January','Q1',2024,FALSE),
(20240103,'2024-01-03','Wednesday',3,1,'January','Q1',2024,FALSE),
(20240106,'2024-01-06','Saturday',6,1,'January','Q1',2024,TRUE),
(20240201,'2024-02-01','Thursday',1,2,'February','Q1',2024,FALSE),
(20240215,'2024-02-15','Thursday',15,2,'February','Q1',2024,FALSE),
(20240301,'2024-03-01','Friday',1,3,'March','Q1',2024,FALSE),
(20240310,'2024-03-10','Sunday',10,3,'March','Q1',2024,TRUE);

-- Insert into dim_product
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P001','Laptop','Electronics','Computers',50000),
('P002','Smartphone','Electronics','Mobile',30000),
('P003','Headphones','Electronics','Accessories',3000),
('P004','Office Chair','Furniture','Chair',8000),
('P005','Desk Lamp','Furniture','Lighting',2000);

-- Insert into dim_customer
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001','John Doe','Mumbai','MH','Consumer'),
('C002','Amit Shah','Delhi','DL','Corporate'),
('C003','Sara Khan','Bangalore','KA','Consumer'),
('C004','Rohit Verma','Pune','MH','Home Office');

-- Insert into fact_sales
INSERT INTO fact_sales
(date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount)
VALUES
(20240101,1,1,2,50000,0,100000),
(20240102,2,2,1,30000,2000,28000),
(20240103,3,3,3,3000,0,9000),
(20240106,4,4,1,8000,500,7500),
(20240201,1,2,1,50000,0,50000),
(20240215,5,1,2,2000,0,4000),
(20240301,2,3,1,30000,3000,27000),
(20240310,3,4,2,3000,0,6000);