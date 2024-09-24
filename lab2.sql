-- 1
create database lab2;

-- 2
create table countries(
    country_id serial primary key,
    country_name varchar,
    region_id integer,
    population integer
);

-- 3
insert into countries(country_name, region_id, population)
values ('Kazakhstan',1,2000000);

-- 4
insert into countries(country_id, country_name)
values (5,'Japan');

-- 5
insert into countries(region_id)
values (null);

-- 6
insert into countries(country_name, region_id, population)
values ('Turkey', 3, 5000000),
       ('Russia', 5, 3000000),
       ('Korea', 4, 20000);

-- 7
alter table countries
alter country_name set default 'Kazakhstan';

-- 8
insert into countries(country_name) values(default);

-- 9
insert into countries default values;

-- 10
create table countries_copy
(
  like countries including all
);

-- 11
insert into countries_copy
select * from countries;

-- 12
update countries
set region_id = 1
where region_id is null;

-- 13
update countries
set population = population*1.1
where population is not null
returning country_name, population as "New Population";

-- 14
delete
from countries
where population < 100000;

-- 15
delete
from countries_copy
using countries
where countries_copy.country_id = countries.country_id
returning *;

-- 16
delete
from countries
returning *;
