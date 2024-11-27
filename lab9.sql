create database lab9;

-- 1
create function increase_value(a integer)
    returns integer as
    $$
    begin
        return a + 10;
    end;
    $$
language plpgsql;

select increase_value(5);

-- 2
create function compare_numbers(a integer, b integer)
    returns varchar as
    $$
    begin
        if a > b then
            return 'Greater';
        elseif a < b then
            return 'Lesser';
        else
            return 'Equal';
            end if;
    end;
    $$
language plpgsql;

select compare_numbers(20, 15);
select compare_numbers(15,20);
select  compare_numbers(20, 20);

-- 3
create function number_series(n integer)
    returns setof integer as
    $$
    declare
        iterator integer :=1;
    begin
        while iterator <= n loop
            return next iterator;
            iterator := iterator+1;
            end loop;
    end;
    $$
language plpgsql;

select number_series(5);

-- 4
create or replace function find_employee(employee_name varchar)
    returns table (
        name varchar,
        surname varchar,
        department_id integer,
        salary integer
        ) as
    $$
    begin
        return query select e.name, e.surname, e.department_id, e.salary
        from employees e
        where e.name = employee_name;
    end;
    $$
language plpgsql;

select find_employee('Aisulu');

-- 5
create function list_products(product_category varchar)
    returns table(
        name varchar,
        price integer,
        category varchar
                 ) as
    $$
    begin
        return query select p.name, p.price, p.category
        from products p
        where p.category = product_category;
    end;
    $$
language plpgsql;

-- 6
create or replace function calc_bonus(id integer)
    returns decimal as
    $$
    declare bonus decimal;
    begin
        select e.salary * 0.1 into bonus
        from employees e
        where e.employee_id = id;
        return bonus;
    end;
    $$
language plpgsql;

drop function calc_bonus(id integer);
drop function update_salary(id integer);

create or replace function update_salary(id integer)
    returns integer as
    $$
    declare
        bonus decimal;
        new_salary decimal;
    begin
        bonus := calc_bonus(id);
        update employees e
        set salary = salary + bonus
        where e.employee_id = id
        returning salary into new_salary;

        return new_salary;
    end;
    $$
language plpgsql;

select calc_bonus(1);
select update_salary(1);

-- 7
create or replace function complex_calculation(id integer, employee_surname varchar)
    returns varchar as
    $$
    declare
        annual_salary integer;
        employee_salary integer;
        employee_name varchar;
    begin
        begin
            select e.salary into employee_salary
            from employees e
            where e.employee_id = id;
            annual_salary := employee_salary * 12;
        end;
        begin
            select e.name into employee_name
            from employees e
            where e.employee_id =id;
        end;
        return employee_name || employee_surname || annual_salary;
    end;
    $$
language plpgsql;

select complex_calculation(1, 'Aidarkyzy');
