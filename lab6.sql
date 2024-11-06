-- 1
create database lab6;

-- 2
create table locations(
    location_id serial primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);

create table departments(
    department_id serial primary key,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations
);

create table employees(
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);

insert into locations (street_address, postal_code, city, state_province)
values ('address1', 010000, 'Astana','Baikonyr'),
       ('address2', 050000, 'Almaty','Medeu'),
       ('address3', 040000, 'Taldykorgan','Zhastar');

insert into departments (department_name, budget, location_id)
values ('IT', 5000, 1),
       ('Business', 3000, 2),
       ('Marketing', 4000, 1),
       ('Design', 2000, 3),
       ('Engineering', 5500, 3);

insert into employees (first_name, last_name, email, phone_number, salary, department_id)
values ('Aisulu', 'Aidarkyzy', 'email1@gmail.com', '87777777777', 2000, 2),
       ('Kazybek', 'Zhaksylyk', 'email2@gmail.com', '87666666666', 3000, 3),
       ('Damir', 'Aidar', 'email3@gmail.com', '87555555655', 2500, 1),
       ('Alua', 'Seitkali', 'email4@gmail.com', '8744444444', 3500, 4),
       ('Alikhan', 'Aliev', 'email5@gmail.com', '8733333333', null,null);


-- 3
select first_name, last_name, e.department_id, d.department_name
from employees e
join departments d on e.department_id = d.department_id;

-- 4
select first_name, last_name, e.department_id, d.department_name
from employees e
join departments d on e.department_id = d.department_id
where d.department_id = 2 or d.department_id = 4;

-- 5
select first_name, last_name, d.department_name, l.city, l.state_province
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id;

-- 6
select *
from departments d
left join employees e on d.department_id = e.department_id;

-- 7
select first_name, last_name, e.department_id, d.department_name
from employees e
left join departments d on e.department_id = d.department_id;
