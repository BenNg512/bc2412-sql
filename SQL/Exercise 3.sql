create database bootcamp_exercise3;
use bootcamp_exercise3;

create table cities(
	id int not null primary key auto_increment,
    city_name varchar(255) not null
);
insert into cities(city_name) values
('City 1'),
('City 2'),
('City 3'),
('City 4');

create table customers(
	id int not null primary key,
    customer_name varchar(255) not null,
    city_id int,
    customer_address varchar(255) not null,
    contact_person varchar(255),
    email varchar(128) not null,
    phone varchar(128) not null,
    foreign key (city_id) references cities(id)
);

insert into customers(id, customer_name, city_id, customer_address, contact_person, email, phone) values
(1, 'Drogerie Wien', 1, 'Deckergasse 15A', 'Emil Steinbach', 'emil@drogeriewien.com', '094234234'),
(2, 'Cosmetics Store', 4, 'Watling Street 347', 'Jeremy Corbyn', 'jeremy@c-store.org', '093923923'),
(3, 'Kosmetikstudio', 3,  'Rothenbaumchaussee 53', 'Willy Brandt',  'willy@kosmetikstudio.com', '0941562222'),
(4, 'Neue Kosmetik', 1, 'Karlsplatz 2', NULL, 'info@neuekosmetik.com', '094109253'),
(5, 'Bio Kosmetik', 2, 'Motzstraße 23', 'Clara Zetkin', 'clara@biokosmetik.org', '093825825'),
(6, 'K-Wien', 1, 'Kärntner Straße 204', 'Maria Rauch-Kallat', 'maria@kwien.org', '093427002'),
(7, 'Natural Cosmetics', 4, 'Clerkenwell Road 14B', 'Glenda Jackson', 'glena.j@natural-cosmetics.com', '093555123'),
(8, 'Kosmetik Plus', 2, 'Unter den Linden 1', 'Angela Merkel', 'angela@k-plus.com', '094727727'), 
(9, 'New Line Cosmetics', 4, 'Devonshire Street 92', 'Oliver Cromwell', 'oliver@nlc.org', '093202404')
;

create table products(
	id int not null primary key,
    sku varchar(32) not null,
    product_name varchar(128) not null,
    product_description text not null,
    current_price decimal(8,2) not null,
    quantity_in_stock int not null
);

insert into products(id, sku, product_name, product_description, current_price, quantity_in_stock) values
(1, '330120', 'Game Of Thrones - URBAN DECAY', 'Game Of Thrones Eyeshadow Palette', 65, 122),
(2, '330121', 'Advanced Night Repair - ESTEE LAUDER', 'Advanced Night Repair Synchronized Recovery Complex II', 98, 51),
(3, '330122', 'Rose Deep Hydration - FRESH', 'Rose Deep Hydration Facial Toner', 45, 34), 
(4, '330123', 'Pore-Perfecting Moisturizer - TATCHA', 'Pore-Perfecting Moisturizer & Cleanser Duo', 25, 393), 
(5, '330124', 'Capture Youth - DIOR', 'Capture Youth Serum Collection', 95 ,74), 
(6, '330125', 'Slice of Glow - GLOW RECIPE', 'Slice of Glow Set', 45, 40), 
(7, '330126', 'Healthy Skin - KIEHL S SINCE 1851', 'Healthy Skin Squad', 68, 154), 
(8, '330127', 'Power Pair! - IT COSMETICS', 'IT is Your Skincare Power Pair! Best-Selling Moisturizer & Eye Cream Duo', 80, 0), 
(9, '330128', 'Dewy Skin Mist -TATCHA', 'Limited Edition Dewy Skin Mist Mini', 20, 281),
(10, '330129', 'Silk Pillowcase - SLIP', 'Silk Pillowcase Duo + Scrunchies Kit', 170, 0)
;

create table invoices(
	id int not null primary key,
    invoice_number varchar(255) not null,
    customer_id int not null,
    user_account_id int not null,
    total_price decimal(8,2) not null,
    time_issued varchar(50),
    time_due varchar(50),
    time_paid varchar(50),
    time_canceled varchar(50),
    time_refunded varchar(50),
    foreign key (customer_id) references customers(id)
);

insert into invoices(id, invoice_number, customer_id, user_account_id, total_price, time_issued, time_due, time_paid, time_canceled, time_refunded) values
(1, 'in_25181b07ba800c8d2fc967fe991807d9', 7, 4, 1436, '7/20/2019 3:05:07 PM', '7/27/2019 3:05:07 PM', '7/25/2019 9:24:12 AM', NULL, NULL),
(2, '8fba0000fd456b27502b9f81e9d52481', 9, 2, 1000, '7/20/2019 3:07:11 PM', '7/27/2019 3:07:11 PM', '7/20/2019 3:10:32 PM', NULL, NULL),   
(3, '3b6638118246b6bcfd3dfcd9be487599', 3, 2, 360, '7/20/2019 3:06:15 PM', '7/27/2019 3:06:15 PM', '7/31/2019 9:22:11 PM' ,NULL, NULL),
(4, 'dfe7f0a01a682196cac0120a9adbb550', 5, 2, 1675, '7/20/2019 3:06:34 PM', '7/27/2019 3:06:34 PM', NULL, NULL, NULL), 
(5, '2a24cc2ad4440d698878a0a1a71f70fa', 6, 2, 9500, '7/20/2019 3:06:42 PM', '7/27/2019 3:06:42 PM', NULL, '7/22/2019 11:17:02 AM', NULL),
(6, 'cbd304872ca6257716bcab8fc43204d7', 4, 2, 150, '7/20/2019 3:08:15 PM', '7/27/2019 3:08:15 PM', '7/27/2019 1:42:45 PM', NULL, '7/27/2019 2:11:20 PM')
;
    
create table invoice_items(
	id int not null primary key,
    invoice_id int not null,
    product_id int not null,
    quantity int not null,
    price decimal(8,2) not null,
    line_total_price decimal(8,2) not null,
    foreign key (invoice_id) references invoices(id),
    foreign key (product_id) references products(id)
);

insert into invoice_items(id, invoice_id, product_id, quantity, price, line_total_price) values
(1, 1, 1, 20, 65, 1300),
(2, 1, 7, 2, 68, 136),
(3, 1, 5, 10, 100, 1000),
(4, 3, 10, 2, 180, 360),
(5, 4, 1, 5, 65, 325),
(6, 4, 2, 10, 95, 950),
(7, 4, 5, 4, 100, 400),
(8, 5, 10, 100, 95, 9500),
(9, 6, 4, 6, 25,100)
;

drop table INVOICE_ITEMS; 
drop table INVOICES;
drop table CUSTOMERS; 
drop table PRODUCTS; 

-- Sample Data 
DELETE FROM INVOICE_ITEMS; 
DELETE FROM INVOICES;
DELETE FROM CUSTOMERS; 
DELETE FROM PRODUCTS; 

-- INSERT INTO CUSTOMERS (id, customer_name, city_id, customer_address, contact_person, email, phone) values
-- (1, 'Drogerie Wien', 1, 'Deckergasse 15A', 'Emil Steinbach', 'abc@gmail.com', 123455678),
-- (2, 'John', 4, 'Deckergasse 1A', '9upper', 'abck@gmail.com', 12345567),
-- (3, 'Mary', 8, 'Deckergasse 18A', '19upper', 'abcd@gmail.com', 1234556789); 

-- INSERT INTO Pproducts(sku, product_name, product_description, current_price, quantity_in_stock) values
-- (1, '330120', '9UP PRODUCT', 'COMPLETELY SUP', 60, 122),
-- (2, '330121', '9UPPER PRODUCT', 'COMPLETELY 9UPPER', 50, 50), 
-- (3, '330122', '9UPPER PRODUCTS', 'SUPER SUPPER', 40, 600),
-- (4, '330123', '9UPPER PRODUCTSS', 'SUPER COMPLETELY 9UPPER', 30, 500); 

-- INSERT INTO invoices(invoice_number, customer_id, user_account_id, total_price, time_issued, time_due, time_paid, time_canceled, time_refunded) values
-- (1, 123456780, 2, 41, 1423, NULL, NULL, NULL, NULL, NULL),
-- (2, 123456780, 3, 42, 1400, NULL, NULL, NULL, NULL, NULL), 
-- (3, 123456780, 2, 43, 17000, NULL, NULL, NULL, NULL, NULL); 

-- INSERT INTO invoice_items(id, invoice_id, product_id, quantity, price, line_total_price) values
-- (1, 1, 1, 46, 23, 920),
-- (2, 1, 2, 4, 20, 80),
-- (3, 1, 3, 4, 10, 40), 
-- (4, 1, 2, 4, 36, 120);

-- Q.1C

with product_sold as (
	select product_id
	from invoice_items i1
	left join invoices i2
	on i1.invoice_id = i2.id
)  
SELECT 'customer' as customer_or_product, c.id as ID, c.customer_name as NAME
FROM customers c
left join invoices i
on c.id = i.customer_id
where i.id is null
UNION
SELECT 'product' as customer_or_product, p.id, p.product_name
FROM products p
left join product_sold ps
on p.id = ps.product_id
where ps.product_id is null
;

-- Q.2
drop table employees;
drop table departments;

create table departments(
	id int not null auto_increment primary key, 
    dept_code varchar(3) unique, 
    dept_name varchar(200) unique
);
insert into departments(id, dept_code, dept_name) values
(1, 'HR', 'Human Resources'),
(2, '9Up', '9Up Department'),
(3, 'SA', 'Sales Department'),
(4, 'IT', 'Informatioin Technology Department')
;

create table employees(
	id int not null auto_increment primary key, 
    employee_name varchar(30) not null,
    salary numeric(8,2),
    phone numeric(15),
	email varchar(50),
    dept_id int not null,
    foreign key (dept_id) references departments(id)
);
insert into employees(id, employee_name, salary, phone, email, dept_id) values
(1, 'John', 20000, 90234567, 'John@gmail.com', 1),
(2, 'Mary', 10000, 90234561, 'Mary@gmail.com', 1),
(3, 'Steve', 30000, 90234562, 'Steve@gmail.com', 3),
(4, 'Sunny', 40000, 90234563, 'Sunny@gmail.com', 4)
; 

select d.dept_code, count(e.dept_id) as employee_no
from departments d
left join employees e
on d.id = e.dept_id
group by d.id, d.dept_code
order by employee_no desc
;

-- Q.2b
delete from departments where id = 5;
insert into departments(id, dept_code, dept_name) values
(5, 'IT', 'Informatioin Technology Department')
;
-- the code works but department is duplicated
-- solution: add unique to the department_code + department_name
