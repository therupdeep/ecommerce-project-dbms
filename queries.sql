@ /home/susnato/Desktop/ecommerce-project-dbms/exec_files/add_to_cart.sql;
select * from cart_item;
select * from cart;


select * from Product where price<1000;

select * from product where price<420 and category_id in(select category_id from category where category_name='Books');

select * from Product where brand='Nestle';


