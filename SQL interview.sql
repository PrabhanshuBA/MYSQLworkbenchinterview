create database test;
use test;
drop table if exists employees;
create table employees(
employee_name varchar(133),
salary integer);

insert into employees (employee_name,salary)
values ('A' ,'24000'),
('C',' 34000'),
('D',' 55000'),
('E',' 75000'),
('F',' 21000'),
('G',' 40000'),
('H','50000');

drop table if exists tble;
create table tble(
id varchar(133),
name varchar(133),
age integer);

insert into tble (id,name,age) 
values ('1','a','21'),
('2','b','23'),
('2','b','23'),
('4','d','22'),
('5','e','25'),
('6','g','26'),
('5','e','25');

drop table if exists tble1;
create table tble1(
name varchar(133),
email varchar(133));


insert into tble1 (name,email) values 
('A','FEEDCSEAWN@EMAIL.COM'),
('B','IYYRWIRYF@EMAIL.COM'),
('C','QZANB@EMAIL.COM'),
('D','POIJN@EMAIL.COM'),
('E','UTYVDHS09@EMAIL.COM'),
('F','VNJV6235263@EMAIL.COM'),
('G','039FNJHC65@EMAIL.COM'),
('H','2738BHSBX5GCS@EMAIL.COM');

drop table if exists tble2;
create table tble2(
ID INTEGER,
name varchar(133),
SALARY INTEGER,
MANAGERID INTEGER);

INSERT INTO TBLE2 (ID,NAME,SALARY,MANAGERID)
VALUES 
('1','JOE','70000','3'),
('2','HENRY','80000','4'),
('3','SAM','60000',NULL),
('4','MAX','90000',NULL);


/* 1.Third highest salary of the employees
	2.removing all the duplicates rows only show unique records in sql
    3.extract username from email
    4.extract mail domain from email
	5.employee earning more than thire manager
    6.employees who are not managers 
*/
    
select * from employees;

-- 1.Third highest salary of the employees
SELECT employee_name, salary from employees order by salary desc limit 2,1;
-- or --
select * from
(select *,rank() over(order by salary desc) rnk from employees) a
where rnk = 3 ;


------------------------------------------------------------------------

select * from tble;

-- 2.removing all the duplicates rows only show unique records in sql

select id,name,age, count(id) as a from tble group by id,name,age having a < 2;
-- or --
select * from 
(select id, name, age, count(id) over (partition by id, name, age) as w,
row_number() over (partition by id, name, age) as a from tble) as b where a < 2 and w < 2;

--------------------------------------------------------------------

select * from tble1;

-- 3.extract username from email
select substring_index(email, '@', 1) as username from tble1;

--------------------------------------------------------------

-- 4.extract mail domain from email
select substring_index(email, '@', -1) as username from tble1;
---------------------------------------------------------------------

select * from TBLE2;

-- 5.employee earning more than thire manager
select a.id, a.name, a.salary as esalary, b.managerid, b.name, b.salary as msalary from TBLE2 a,  TBLE2 b 
where a.id = b.managerid and a.salary > b.salary;
-- or --
select a.id, a.name, a.salary as esalary, b.managerid, b.name, b.salary as msalary from TBLE2 a join TBLE2 b 
on a.id = b.managerid where  a.salary > b.salary;
----------------------------------------------------------------

-- 6.employees who are not managers 
select * from TBLE2 where managerid is not null; 