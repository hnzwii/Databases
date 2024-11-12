create database lab7;

create table countries(
    country_id serial primary key,
    name varchar
);

create table employees(
    employee_id serial primary key,
    name varchar,
    surname varchar,
    salary integer,
    department_id integer references departments
);

create table departments(
    department_id serial primary key,
    name varchar,
    budget integer
);

insert into countries (name)
values('Kazakhstan'),
      ('Russia'),
      ('USA'),
      ('China'),
      ('Germany'),
      ('France'),
      ('Turkey'),
      ('Kyrgyzstan'),
      ('Japan'),
      ('Korea');

insert into departments(name, budget)
values('department1',5000),
      ('department2',6000),
      ('department3',7000),
      ('department4',10000),
      ('department5',8000);

insert into employees(name, surname, salary, department_id)
values('Aisulu','Aidarkyzy', 1000,5),
      ('Damir','Aidaruly',1500,15),
      ('Alua','Seitkalyeva',2000,20),
      ('Maryash','Kaskarbayev',500,8),
      ('Aidar','Orazymbetov',2500,40);

-- 1
explain analyse
select *
from countries
where name='China';

create index countries_name_index on countries(name);
drop index countries_name_index;

-- 2
explain analyse
select *
from employees
where name = 'Aisulu'
and surname = 'Aidarkyzy';

create index employees_name_surname_index on employees(name,surname);
drop index employees_name_surname_index;

-- 3
explain analyse
select *
from employees
where salary < 2000
and salary >1000;

create unique index employees_employee_id_unique_index on employees(employee_id);

-- 4
explain analyse
select *
from employees
where substring(name from 1 for 4) = 'Dami';

create index employees_name_index on employees(substring(name from 1 for 4));

-- 5
explain analyse
select *
from employees e
join departments d on e.department_id = d.department_id
where d.budget > 6000 and e.salary < 2000;

create index employees_salary_index on employees(salary);
create index departments_department_id_budget_index on departments(department_id, budget);
