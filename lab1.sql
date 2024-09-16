create database lab1;

create table users(
    id serial not null,
    firstname varchar(50),
    lastname varchar(50)
);

alter table users
add isadmin int;

alter table users
alter column isadmin set data TYPE boolean
using isadmin::boolean;

alter table users
alter isadmin set default false;

alter table users
add primary key (id);

insert into users (firstname, lastname)
values ('Aisulu', 'Aidarkyzy');

create table tasks(
    id serial primary key,
    name varchar(50),
    user_id int
);

drop table tasks;
drop database lab1;


drop table users;
