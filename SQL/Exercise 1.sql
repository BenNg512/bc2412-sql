create database bootcamp_exercise1;
use bootcamp_exercise1;

create table regions(
	region_id int primary key AUTO_INCREMENT,
    region_name varchar(25)
);

insert into regions(region_name)
values('Europe'),
('North America'),
('Asia');

create table countries(
	country_id char(2) primary key UNIQUE,
    country_name varchar(40) UNIQUE, 
    region_id int,
    foreign key (region_id) references regions(region_id)
);

insert into countries(country_id, country_name, region_id)
values ('DE', 'Germany', 1),
('IT', 'Italy', 1),
('JP', 'Japan', 3),
('US', 'United State', 2)
;

create table locations(
	location_id int primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12),
    country_id char(2),
    foreign key (country_id) references countries(country_id)
);

insert into locations(location_id, street_address, postal_code, city, state_province, country_id)
values(1000, '1297 Via Cola Di Rie', 989, 'Roma', '', 'IT'),
(1100, '93091 Calle della Te', 10934, 'Venice', '', 'IT'), 
(1200, '2017 Shinjuku-ku', 1689, 'Tokyo', 'Tokyo', 'JP'),
(1400, '2014 Jabberwocky Rd', 26192, 'Southlake', 'Texas', 'US')
;

create table departments(
	department_id int primary key,
    department_name varchar(30),
    manager_id int,
    location_id int,
    foreign key (location_id) references locations(location_id)
);
insert into departments(department_id, department_name, manager_id, location_id)
values(10, 'Administration', 200, 1100),
(20,'Marketing', 201, 1200),
(30, 'Purchasing', 202, 1400)
;

create table jobs(
	job_id varchar(10) primary key, 
    job_title varchar (35),
    min_salary decimal(13,2),
    max_salary decimal(13,2)
);

insert into jobs(job_id, job_title, min_salary, max_salary)
value('MK_REP', 'marketing representative', 15000, 25000),
('IT_PROG', 'IT programmeer', 25000, 50000),
('ST_CLERK', 'Clerk', 15000, 25000)
;

create table employees(
	employee_id int primary key,
    first_name varchar(20),
    last_name varchar(25),
    email varchar(25),
    phone_number varchar(20),
    hire_Date date,
    job_id varchar(10),
    salary decimal(13,2),
    commission_pct decimal(13,2),
    manager_id int,
    department_id int,
	foreign key (job_id) references jobs(job_id),
    foreign key (department_id) references departments(department_id)
);
insert into employees(employee_id, first_name, last_name, email, phone_number, hire_Date, job_id, salary, commission_pct, manager_id, department_id)
values
(100, 'Steven', 'King', 'SKING', 515-1234567, '1987-06-17', 'ST_CLERK', 24000.00, 0.00, 109, 10),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515_12345678', '1987-06-18', 'MK_REP', 17000.00, 0.00, 103, 20),
(102, 'Les', 'De Han', 'LDEHAAN', '515-1234569', '1987-06-19','IT_PROG', 17000.00, 0.00, 108, 30 ),
(103, 'Alexander', 'Hunold', 'AHUNOLD', '590-4234567', '1987-06-20', 'MK_REP', 9000.00, 0.00, 105, 20),
(200, 'Ben', 'Ng', 'BEN', '590-4234568', '2019-05-31', 'IT_PROG', 10000.00, 0.00, 105, 30),
(201, 'Candy', 'Hung', 'CANDY', '590-4234569', '2020-06-10', 'ST_CLERK', 11000.00, 0.00, 105, 10),
(202, 'Derick', 'Chan', 'DERICK', '590-4234570', '2021-10-20', 'MK_REP', 12000.00, 0.00, 105, 20)
;

create table job_history(
    employee_id int,
    start_date date,
    end_date date,
    job_id varchar(10),
    department_id int,
    foreign key (employee_id) references employees(employee_id),
    foreign key (department_id) references departments(department_id)
);
insert into job_history(employee_id, start_date, end_date, job_id, department_id)
values(102,'1993-01-13', '1998-07-24','IT_PROG', 20),
(101,'1989-09-21', '1993-10-27','MK_REP', 10),
(101,'1993-10-28', '1997-03-15','MK_REP', 30),
(100,'1992-02-17', '1999-12-19','ST_CLERK', 30),
(103,'1998-03-24', '1999-12-31','MK_REP', 20)
;


-- Q3.
select l.location_id, l.street_address, l.city, l.state_province, c.country_name
from locations l
inner join countries c
on l.country_id = c.country_id
;

-- Q4.
select last_name, last_name, department_id
from employees
;

-- Q5.
with location_country_id as(
	select l.location_id, c.country_name
	from locations l
	left join countries c
	on l.country_id = c.country_id
    ), 
    employee_list as(
	select e.first_name, e.last_name, e.job_id, e.department_id, d.location_id
	from employees e
	left join departments d
	on e.department_id = d.department_id
    )
select el.first_name, el.last_name, el.job_id, el.department_id
from employee_list el
left join location_country_id lc
on el.location_id = lc.location_id
where lc.country_name = 'Japan'
;

-- Q.6
select e.employee_id, e.last_name, e.manager_id, m.last_name as manager_lastname
from employees e
left join employees m
on e.manager_id = m.employee_id;

-- Q.7
select first_name, last_name , hire_date
from employees e1
where hire_date > '1987-06-19'
;

-- Q.8
select d.department_id, count(1) as employee_count
from departments d
inner join employees e
on d.department_id = e.department_id
group by d.department_id
;

-- Q.9
select employee_id, job_id as job_title, DATEDIFF(end_date, start_date) AS duration_in_days
from job_history
where department_id = 30
;

-- Q.10
with location_city_country as(
	select l.location_id, l.city, c.country_name
	from locations l
	left join countries c
	on l.country_id = c.country_id
    ), 
    department_manager as(
    select department_name, location_id, concat(m.first_name, ' ', m.last_name) as manager_name
	from departments d
	left join employees m
	on d.manager_id = m.employee_id
    )
select department_name, manager_name, city, country_name
from department_manager dm
left join location_city_country lc
on dm.location_id = lc.location_id
;

-- Q.11
with department_average_salary as(
	SELECT department_id, round(AVG(salary),2) AS average_salary
	FROM employees
	GROUP BY department_id
    )
select d.department_name, ds.average_salary
from departments d
left join department_average_salary ds
on d.department_id = ds.department_id
;

-- Q.12
select * from jobs;

UPDATE jobs j
JOIN (
    SELECT job_id,
           MIN(salary) AS new_min_salary,
           MAX(salary) AS new_max_salary
    FROM employees
    GROUP BY job_id
) e ON j.job_id = e.job_id
SET j.min_salary = e.new_min_salary,
    j.max_salary = e.new_max_salary;
select * from jobs;

create table job_grades(
	grade_level varchar(2),
    lowest_sal decimal(12,2),
    highest_sal decimal(12,2)
);
insert into job_grades(grade_level, lowest_sal, highest_sal)
values('A', 10000.00, 20000.00),
('B', 20001.00, 30000.00),
('C', 30001.00, 40000.00),
('D', 40001.00, 50000.00),
('E', 50001.00, 60000.00);









-- drop tables in order:
drop table job_grades;
drop table job_history; 
drop table employees; 
drop table jobs;
drop table departments; 
drop table locations; 
drop table countries; 
drop table regions; 



    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    