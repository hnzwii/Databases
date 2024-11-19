-- 1
create database lab8;

-- 2
create table salesman(
    salesman_id serial primary key,
    name varchar,
    city varchar,
    commision float
);

create table customers(
    customer_id serial primary key,
    cust_name varchar,
    city varchar,
    grade integer,
    salesman_id integer references salesman
);

create table orders(
    ord_no serial primary key,
    purch_amt float,
    ord_date timestamp,
    customer_id integer references customers,
    salesman_id integer references salesman
);

insert into salesman (salesman_id, name, city, commision)
values
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'Rome', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

insert into customers (customer_id, cust_name, city, grade, salesman_id)
values
(3002, 'Nick Rimando', 'New York', 100, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3001, 'Brad Guzan', 'London', 100, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3007, 'Brad Davis', 'New York', 200, 5001),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

insert into orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
values
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001);

-- 3
create role junior_dev login;

-- 4
create view salesman_city_view as
select *
from salesman
where city = 'New York';

-- 5
create view salesman_cust_name_view as
select s.name, c.cust_name
from orders o
join customers c on c.customer_id = o.customer_id
join salesman s on s.salesman_id = o.salesman_id;

grant all privileges on salesman_cust_name_view to junior_dev;

-- 6
create view highest_grade_view as
select *
from customers
where grade = (select grade
               from customers
               order by grade desc limit 1);

grant select on highest_grade_view to junior_dev;

-- 7
create view num_salesman_city_view as
select city, count(salesman_id)
from salesman
group by city;

-- 8
create view salesman_customer_view as
select s.salesman_id, count(c.customer_id)
from salesman s
join customers c on s.salesman_id = c.salesman_id
group by s.salesman_id
having count(c.customer_id) > 1;

-- 9
create role intern;
grant junior_dev to intern;
