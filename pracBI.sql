CREATE TABLE employee1 (
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    ID INT NOT NULL,
    hire_date DATE,
    termination_date DATE,
    salary INT,
    PRIMARY KEY (ID)
);

CREATE TABLE annual_reviews (
    ID INT NOT NULL,
    empID INT NOT NULL,
    ReviewDate DATE
);

insert into employee1 (first_name, last_name, ID, hire_date, termination_date, salary)
values
	('Bob', 'Smith', 1, '2009-06-20', '2006-01-01', 10000),
    ('Joe', 'Jarrod', 2, '2010-02-12', null, 20000),
    ('Nancy', 'Soley', 3, '2012-03-14', null, 30000),
    ('Keith', 'Widjaja', 4, '2013-09-10', '2014-01-01', 20000),
    ('Kelly', 'Smalls', 5, '2013-09-10', null, 20000),
    ('Frank', 'Nguyen', 6, '2015-04-10', '2015-05-01', 60000);

insert into annual_reviews (ID, EmpID, ReviewDate)
values
	(10, 1, '2016-01-01'),
    (20, 2, '2016-04-12'),
    (30, 10, '2015-02-13'),
    (40, 22, '2010-10-12'),
    (50, 11, '2009-01-01'),
    (60, 12, '2009-03-03'),
    (70, 13, '2008-12-01'),
    (80, 1, '2003-04-12'),
    (90, 1, '2014-04-30');

select * from employee1;
select * from annual_reviews;

SELECT 
    CONCAT(first_name, ' ', last_name)
FROM
    employee1
WHERE
    termination_date IS NULL
ORDER BY last_name , first_name;

SELECT 
    e.first_name, e.last_name
FROM
    employee1 e
        LEFT JOIN
    annual_reviews a ON e.id = a.empid
WHERE
    a.ReviewDate IS NULL
ORDER BY e.hire_date;

SELECT 
    DATEDIFF(MIN(hire_date), MAX(hire_date)) AS difference_day
FROM
    employee1
WHERE
    termination_date IS NULL;

CREATE TABLE dqlabsesat1 (
    nama VARCHAR(100) NOT NULL,
    operator VARCHAR(100) NOT NULL
);

insert into dqlabsesat1( nama, operator)
values
('cyntia', 'Telkomsel'),
('Rheny', 'Indosat'),
('Elita', 'XL'),
('Vannesa', 'Smartfren'),
('Lola', 'Axis');

CREATE TABLE dqlabsesat2 (
    nama VARCHAR(100) NOT NULL,
    smartphone VARCHAR(100) NOT NULL
);

insert into dqlabsesat2( nama, smartphone)
values
('cyntia', 'iPhone'),
('Rheny', 'Samsung'),
('Elita', 'Xiaomi'),
('Vannesa', 'Oppo'),
('Lola', 'LG');

SELECT 
    *
FROM
    dqlabsesat1 d1
        INNER JOIN
    dqlabsesat2 d2 ON d1.nama = d2.nama; 

select Customer_ID from customer;
select * from superstore;
#soal nomor 1 jumlah customer per kota
SELECT 
    city, COUNT(customer_ID)
FROM
    customer
GROUP BY city;
#soal nomor 2 jumlah order per kota
SELECT 
    c.city, COUNT(s.order_ID)
FROM
    superstore s
        INNER JOIN
    customer c ON s.customer_ID = c.customer_ID
GROUP BY c.city;

#soal nomor 3 mencari first order date pada customer
select customer_ID, min(order_date)
from superstore
group by customer_ID;

#soal nomor 4 mencari order partama dari setiap kota dan hari
SELECT 
    t2.city,
    t1.first_order_date,
    COUNT(t1.customer_ID) number_of_customer
FROM
    (SELECT 
        customer_ID, MIN(order_date) first_order_date
    FROM
        superstore
    GROUP BY 1) t1
        INNER JOIN
    customer t2 ON t1.customer_ID = t2.customer_ID
GROUP BY city , first_order_date;

SELECT 
    t1.customer_ID, t1.sales
FROM
    superstore t1
        INNER JOIN
    (SELECT 
        customer_id, MIN(order_date) as first_order_date
	FROM
        (SELECT 
        customer_id, order_date
		FROM
        superstore
		ORDER BY order_id)
    GROUP BY 1) 
    t2 ON t1.customer_id = t2.Customer_ID
        AND t1.first_order_date = t2.first_order_date;
        
        

SELECT 
    city, COUNT(customer_ID)
FROM
    customer
GROUP BY city;

select * from superstore;

SELECT 
    c.city, COUNT(s.order_id)
FROM
    superstore s
        JOIN
    customer c ON s.Customer_ID = c.Customer_ID
GROUP BY c.city;

SELECT 
    customer_id, MIN(order_date)
FROM
    superstore
GROUP BY customer_id;

SELECT 
    c.city, COUNT(s.customer_ID) AS number_of_user
FROM
    (SELECT 
        customer_id, MIN(order_date)
    FROM
        superstore
    GROUP BY Customer_ID) s
        INNER JOIN
    customer c ON s.customer_ID = c.Customer_ID
GROUP BY c.city , s.customer_ID
order by number_of_user desc;



SELECT 
    c.city,
    s.first_buy,
    COUNT(*) as total_user
FROM
    (SELECT 
        customer_id, MIN(order_date) AS first_buy
    FROM
        superstore
    GROUP BY Customer_ID) s
        INNER JOIN
    customer c ON s.customer_id = c.Customer_id
    group by c.city, s.first_buy
    order by total_user desc;
    
    
select t1.customer_id, t1.first_buy, sales
from 
(select customer_id, min(order_date) as first_buy, sales
from superstore
group by customer_id) t1;

select customer_id, order_date from superstore;

SELECT 
    t1.Customer_ID, t1.sales
FROM
    superstore t1
        INNER JOIN
    (SELECT 
        t3.customer_id, MIN(t3.Order_Date) first_order_date
    FROM
        (SELECT 
        customer_id, order_date
    FROM
        superstore) t3
    GROUP BY customer_id) t2 ON t1.Customer_ID = t2.Customer_ID
        AND t1.order_date = t2.first_order_date;


select * from superstore;
SELECT 
    order_ID, region, product_ID, sales
FROM
    superstore
WHERE
    sales > 900;
    
SELECT 
    t1.customer_id, t1.first_buy1, t1.sales
FROM
    (SELECT 
        customer_id, MIN(order_date) AS first_buy1, sales
    FROM
        superstore
    GROUP BY customer_id) t1;

select customer_id, category, sales from superstore;

select * from superstore;
SELECT 
    customer_id,
    region,
    country_region,
    category,
    sub_category,
    sales,
    profit
FROM
    superstore
group by Customer_ID
order by sales desc;

SELECT 
    t1.customer_id, t1.first_buy, t1.region
FROM
    (SELECT 
        customer_id, MAX(order_date) AS first_buy, region
    FROM
        superstore
    GROUP BY customer_id) t1
    
