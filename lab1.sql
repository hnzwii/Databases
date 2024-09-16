-- 1
create database lab1;

-- 2
create table users(
    id serial not null,
    firstname varchar(50),
    lastname varchar(50)
);

-- 3
alter table users
add isadmin int;

-- 4
alter table users
alter column isadmin set data TYPE boolean
using isadmin::boolean;

-- 5
alter table users
alter isadmin set default false;

-- 6
alter table users
add primary key (id);

insert into users (firstname, lastname)
values ('Aisulu', 'Aidarkyzy');

-- 7
create table tasks(
    id serial primary key,
    name varchar(50),
    user_id int
);

-- 8
drop table tasks;

-- 9
drop database lab1;


-- drop table users;
