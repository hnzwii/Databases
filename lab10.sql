create database lab10;

create table books(
    book_id integer primary key,
    title varchar,
    author varchar,
    price decimal,
    quantity integer
);

create table orders(
    order_id integer primary key,
    book_id integer references books,
    customer_id integer,
    order_date Date,
    quantity integer
);

create table customers(
    customer_id integer primary key,
    name varchar,
    email varchar
);

insert into books(book_id, title, author, price, quantity)
values(1, 'Database 101', 'A.Smith', 40.00, 10),
      (2, 'Learn SQL', 'B.Johnson', 35.00, 15),
      (3, 'Advanced DB', 'C.Lee', 50.00, 5);

insert into customers(customer_id, name, email)
values(101, 'John Doe', 'johndoe@example.com'),
      (102, 'Jane Doe', 'janedoe@example.com');

-- 1
begin;

insert into orders(order_id, book_id, customer_id, order_date, quantity)
values (1, 1, 101, current_date, 2);

update books
    set quantity = quantity - 2
where book_id = 1;

commit;

select * from orders;
select * from books;

-- 2

update books
set quantity = 13
where book_id = 3;

do $$
    declare available_quantity integer;
    begin
        select quantity
        into available_quantity
        from books
        where book_id = 3;

        if available_quantity < 10 then
            rollback;
            return;
        end if;

        insert into orders(order_id, book_id, customer_id, order_date, quantity)
        values (2,3,102, current_date,10);

        update books
        set quantity = quantity - 10
        where book_id = 3;
    commit;
    end;
    $$
language plpgsql;

-- 3
begin transaction isolation level read committed;

update books
set price = price - 10
where book_id = 2;

begin transaction isolation level read committed;

select price from books;

commit;

-- 4
begin;
update customers
set email =  'example@example.com'
where customer_id = 101;
commit;

select * from customers;
