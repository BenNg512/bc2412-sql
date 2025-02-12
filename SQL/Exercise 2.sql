create database bootcamp_exercise2;
use bootcamp_exercise2;

CREATE TABLE WORKERS ( 
WORKER_ID INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
FIRST_NAME CHAR(25), 
LAST_NAME CHAR(25), 
SALARY NUMERIC(15), 
JOINING_DATE DATETIME, 
DEPARTMENT CHAR(25)
); 

INSERT INTO WORKERS
(FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES 
('Monika', 'Arora', 100000, '21-02-20 09:00:00', 'HR'), 
('Niharika', 'Verma', 80000, '21-06-11 09:00:00', 'Admin'), 
('Vishal', 'Singhal', 300000, '21-02-20 09:00:00', 'HR'), 
('Mohan', 'Sarah', 300000, '12-03-19 09:00:00', 'Admin'), 
('Amitabh', 'Singh', 500000, '21-02-20 09:00:00', 'Admin'), 
('Vivek', 'Bhati', 490000, '21-06-11 09:00:00', 'Admin'), 
('Vipul', 'Diwan', 200000, '21-06-11 09:00:00', 'Account'), 
('Satish', 'Kumar', 75000, '21-01-20 09:00:00', 'Account'), 
('Geetika', 'Chauhan', 90000, '21-04-11 09:00:00', 'Admin')
;

-- Task1
CREATE TABLE BONUS ( 
WORKER_REF_ID INTEGER NOT NULL, 
BONUS_AMOUNT NUMERIC (10), 
BONUS_DATE DATETIME, 
FOREIGN KEY (WORKER_REF_ID) REFERENCES Workers (WORKER_ID) 
);
insert into BONUS(
WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) values
(6, 32000, '21-11-02'),
(6, 20000, '22-11-02'),
(5, 21000, '21-11-02'),
(9, 30000, '21-11-02'),
(8, 4500, '22-11-02')
;

-- Task 2
with salary_rank as (
select first_name, last_name, salary, ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
from workers
order by salary desc
)
SELECT concat(first_name, ' ', last_name) as full_name, salary second_highest
FROM salary_rank
WHERE row_num = 2;

-- Taks 3
with department_max_sal as(
select department, max(salary) as max_salary
from workers
group by department
)
select concat(w.first_name, ' ', w.last_name) as full_name, w.department, max_salary
from workers w
inner join department_max_sal dms
where w.salary = dms.max_salary and w.department = dms.department
;

-- Task 4
select concat(w1.first_name, ' ', w1.last_name) as worker1,
		concat(w2.first_name, ' ', w2.last_name) as worker2
from workers w1
inner join workers w2
on w1.worker_id < w2.worker_id
where w1.salary = w2.salary and w1.first_name <> w2. first_name and w1.last_name <> w2.last_name;

-- Task 5
select concat(w.first_name, w.last_name) as full_name, w.salary, b.bonus_amount
from workers w
left join bonus b
on w.worker_id = b.worker_ref_id and year(b.bonus_date) = 2021 and year(joining_date) >= 2021;

-- Task 6
-- need to clear bonus table first (contains FK)
delete from bonus;
delete from workers;

-- Task 7
-- if insert new data into workers table, new id will be used instead of the original worker ids
-- solution1: insert the originial tables by using the latest ids in workers table (
-- workers id 1-9 -> 10-18 after new insertion
INSERT INTO WORKERS
(FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES 
('Monika', 'Arora', 100000, '21-02-20 09:00:00', 'HR'), 
('Niharika', 'Verma', 80000, '21-06-11 09:00:00', 'Admin'), 
('Vishal', 'Singhal', 300000, '21-02-20 09:00:00', 'HR'), 
('Mohan', 'Sarah', 300000, '12-03-19 09:00:00', 'Admin'), 
('Amitabh', 'Singh', 500000, '21-02-20 09:00:00', 'Admin'), 
('Vivek', 'Bhati', 490000, '21-06-11 09:00:00', 'Admin'), 
('Vipul', 'Diwan', 200000, '21-06-11 09:00:00', 'Account'), 
('Satish', 'Kumar', 75000, '21-01-20 09:00:00', 'Account'), 
('Geetika', 'Chauhan', 90000, '21-04-11 09:00:00', 'Admin')
;
insert into BONUS(
WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) values
(15, 32000, '21-11-02'),
(15, 20000, '22-11-02'),
(14, 21000, '21-11-02'),
(18, 30000, '21-11-02'),
(17, 4500, '22-11-02')
;

-- solution2: drop tables and insert -> faster
drop table bonus;
drop table workers; 

CREATE TABLE WORKERS ( 
WORKER_ID INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, 
FIRST_NAME CHAR(25), 
LAST_NAME CHAR(25), 
SALARY NUMERIC(15), 
JOINING_DATE DATETIME, 
DEPARTMENT CHAR(25)
); 

INSERT INTO WORKERS
(FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES 
('Monika', 'Arora', 100000, '21-02-20 09:00:00', 'HR'), 
('Niharika', 'Verma', 80000, '21-06-11 09:00:00', 'Admin'), 
('Vishal', 'Singhal', 300000, '21-02-20 09:00:00', 'HR'), 
('Mohan', 'Sarah', 300000, '12-03-19 09:00:00', 'Admin'), 
('Amitabh', 'Singh', 500000, '21-02-20 09:00:00', 'Admin'), 
('Vivek', 'Bhati', 490000, '21-06-11 09:00:00', 'Admin'), 
('Vipul', 'Diwan', 200000, '21-06-11 09:00:00', 'Account'), 
('Satish', 'Kumar', 75000, '21-01-20 09:00:00', 'Account'), 
('Geetika', 'Chauhan', 90000, '21-04-11 09:00:00', 'Admin')
;

CREATE TABLE BONUS ( 
WORKER_REF_ID INTEGER, 
BONUS_AMOUNT NUMERIC (10), 
BONUS_DATE DATETIME, 
FOREIGN KEY (WORKER_REF_ID) REFERENCES Workers (WORKER_ID) 
);
insert into BONUS(
WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) values
(6, 32000, '21-11-02'),
(6, 20000, '22-11-02'),
(5, 21000, '21-11-02'),
(9, 30000, '21-11-02'),
(8, 4500, '22-11-02')
;
