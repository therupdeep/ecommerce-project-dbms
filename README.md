# ecommerce-project-dbms

This repository contains all the materials used in the making of the E-commerce DBMS-SQL project assigned to us during our elective course INFO3132(Distributed DBMS). 

## Updates Required

1. checkout procedure to be added. Register,login,show_balance,addmoney,add_to_cart,delete_from_cart working.
2. [executable_files](https://github.com/therupdeep/ecommerce-project-dbms/blob/main/executable_files) folder has files which have to executed by the user to perform an action like login,register,etc.
3. ~~@Susnato implement the cardinality changes described in cardinality.md~~
4. ~~Remove the online shopping site entity from the ERD diagram as we cannot make the Online Shopping site table with no attributes. Also remove its relationships with other tables.~~

## Important Stuff

1. [Procedures](https://github.com/therupdeep/ecommerce-project-dbms/blob/main/procedures.sql)
2. [Executable files by User](https://github.com/therupdeep/ecommerce-project-dbms/blob/main/executable_files)
3. PL/SQL almanac - https://www.tutorialspoint.com/plsql/index.htm
4. [ERD](https://github.com/therupdeep/ecommerce-project-dbms/blob/main/ERD.pdf)
5. [Cardinality](https://github.com/therupdeep/ecommerce-project-dbms/blob/main/cardinality.md)
6. [Schema](https://github.com/therupdeep/ecommerce-project-dbms/blob/main/schema.sql)

## User Queries

Create a new file queries.sql for user performed queries.

### Queries to be added:-

1. details of all products present in cart along with total cost of cart
2. details of all products lesser than a particular price 
3. details of all products lesser than a particular price and belonging to particular category
4. details of all products belonging to particular brand

### Example : To select details of all products in a particular category

select * from product where category_id in 
(select category_id from category where category_name = 'user_input');