create or replace package global as
	email_id customer.email_id%type;
end global;
/

create or replace package query as
	category_id category.category_id%type;
	brand product.brand%type;
end query;
/

create or replace procedure register(
	name customer.name%type,
	address customer.address%type,
	email_id customer.email_id%type;
	phone_number customer.phone_number%type,
	password customer.password%type
) 
is
	flag integer:=0;
	new_customer_id customer.customer_id%type;
	new_cart_id customer.cart_id%type;
	max_customer_id customer.customer_id%type;
	max_cart_id customer.cart_id%type;
begin
	--selecting rows one by one
	for t in (select email_id,phone_number from customer) loop
	if (substr(email_id,-10,10)!='@gmail.com') || substr(email_id,-10,10)!='@yahoo.com')) then
	flag:=1;
	end if;
	 if email_id = t.email_id then
	 	--if given email_id already exists in the customer table
	 	dbms_output.put_line('Enter different Email ID. This email id already exists');
	 	flag:=1;
	 end if;
	 if phone_number = t.phone_number then
	 	--if given phone number already exists in the customer table
	 	dbms_output.put_line('Enter different Phone Number. This phone number is taken');
	 	flag:=1;
	 end if;
	 if flag = 1 then
	 	--remaining statements are not executed
	 	return;
	 end if;
	end loop;
	select max(customer_id),max(cart_id) into max_customer_id,max_cart_id from customer;
	--if no customer exists in the customer table
	if max_customer_id is null then
		--creating customer id and cart id by concatenating corresponding prefix with 1
		new_customer_id:='cst'||1;
		new_cart_id:='crt'||1;
	else
		--creating customer id and cart id by concatenating corresponding prefix with (number of customers+1)
		--for example if max(customer_id) returns cst4 then customer_id of the new user is cst5
		new_customer_id:='cst'||(to_number(substr(max_customer_id,4))+1);
		new_cart_id:='crt'||(to_number(substr(max_cart_id,4))+1);
	end if;
	insert into cart values(new_cart_id,0);
	insert into customer values(new_customer_id,name,address,phone_number,username,password,0,new_cart_id);
	dbms_output.put_line('You are successfully registered');
	login(username,password);
end;
/

create or replace procedure login(
    email_id customer.email_id%type,
	password customer.password%type
)
as
begin 
    for t in (select email_id,password from customer) loop
        if email_id = t.email_id and password = t.password then
            dbms_output.put_line('You are logged in');
            --setting the global variable username to the value of the username of the current user
            global.email_id := email_id;
            --executing show_balance procedure to show the balance in the wallet of the user
            show_balance;
            return;
        end if;
    end loop;
    --if username and password do not match with any of the records in the customer table
    dbms_output.put_line('Login Unsuccessful');
end;
/

create or replace procedure addmoney(
	amount customer.wallet%type
)
as
begin
	update customer
	set wallet = wallet+amount
	where username = global.username;
	--when updation is not successful
	--sql%rowcount returns the number of rows affected by an insert,delete or update statement
	--therefore if sql%rowcount is not equal to 1 i.e, if update is not successful this is executed
	if sql%rowcount != 1 then
		dbms_output.put_line('You are not logged in');
	else
		dbms_output.put_line('Wallet Updated!');
	end if;
	show_balance;	
end; 
/

create or replace procedure show_balance
as 
	balance customer.wallet%type;
begin
	select wallet into balance
	from customer
	where username = global.username;
	dbms_output.put_line('Current balance : '||balance);
exception
	--when select query doesn't return any rows i.e, global variable username doesn't have the current username 
	when no_data_found then
		dbms_output.put_line('You are not logged in');
end;
/

create or replace procedure add_to_cart(
	product_id_input cart_item.product_id%type,
	quantity_input cart_item.quantity%type
)
as
	cart_id_fetched cart_item.cart_id%type;
	price_fetched product.price%type;
	flag integer;
begin
	--fetching cart_id of the current customer
	select cart_id into cart_id_fetched
	from customer
	where username = global.username;
	--fetching price of product to be added
	select price into price_fetched
	from product
	where product_id = product_id_input;
	--fetching count of rows containing the particular product in the current cart of the user
	select count(*) into flag
	from cart_item 
	where cart_id=cart_id_fetched and product_id=product_id_input;
	--checking if product already exists in cart. If yes we increase quantity
	if flag=1 then
		update cart_item
		set quantity=quantity+quantity_input
		where product_id = product_id_input and cart_id = cart_id_fetched;
	else
		insert into cart_item values(product_id_input,quantity_input,cart_id_fetched);
	end if;
	--updating total cost of the cart items
	update cart
	set total_cost=total_cost+price_fetched*quantity_input
	where cart_id = cart_id_fetched;
	dbms_output.put_line('Cart Updated');
	view_cart;
exception
	when no_data_found then
		dbms_output.put_line('You are not logged in');
end;
/

create or replace procedure delete_from_cart(
	product_id_input cart_item.product_id%type,
	quantity_input cart_item.quantity%type
)
as
	cart_id_fetched cart_item.cart_id%type;
	quantity_fetched cart_item.quantity%type;
	price_fetched product.price%type;
	flag integer;
begin
	--fetching cart_id of the current customer
	select cart_id into cart_id_fetched
	from customer
	where username = global.username;
	--fetching count of rows containing the particular product in the current cart of the user
	select count(*) into flag
	from cart_item
	where cart_id=cart_id_fetched and product_id=product_id_input;
	--checking if product exists in cart
	if flag=1 then
		--fetching quantity of the product present in cart
		select quantity into quantity_fetched
		from cart_item
		where product_id = product_id_input and cart_id=cart_id_fetched;
		--checking if quantity to be deleted is lesser than quantity present in cart. If yes we decrease quantity
		if (quantity_input < quantity_fetched) then
			update cart_item
			set quantity = quantity-quantity_input
			where product_id = product_id_input and cart_id=cart_id_fetched;
		--checking if quantity to be deleted is equal to quantity present in cart. If yes we delete the particular row
		elsif (quantity_input = quantity_fetched) then
			delete from cart_item
			where product_id = product_id_input and cart_id=cart_id_fetched;
		--checking if quantity to be deleted is greater than quantity present in cart. If yes we print the error
		else 
			dbms_output.put_line('Number of items to be deleted exceeding quantity of the product present in cart');
		end if;
		--checking if updation is required in cart table
		if (quantity_input <= quantity_fetched) then
			--fetching price of product to be added
			select price into price_fetched
			from product
			where product_id = product_id_input;
			--updating total cost of the cart items
			update cart
			set total_cost=total_cost-price_fetched*quantity_input
			where cart_id = cart_id_fetched;
			dbms_output.put_line('Cart Updated');
			view_cart;
		end if;
	else 
		dbms_output.put_line('Product to be deleted is not added to cart');
	end if;
exception
	when no_data_found then
		dbms_output.put_line('You are not logged in');
end;
/

create or replace procedure checkout
as
	quantity_fetched product.quantity%type;
	wallet_fetched customer.wallet%type;
	total_cost_fetched cart.total_cost%type;
	customer_id_fetched customer.customer_id%type;
	cart_id_fetched customer.cart_id%type;
	date_fetched transaction.transaction_date%type;
	max_transaction_id transaction.transaction_id%type;
	new_transaction_id transaction.transaction_id%type;
	flag integer:=0;
begin
	for t in (select * from cart_item where cart_id in(select cart_id from customer where username = global.username)) loop
		--fetching availability of the product
		select quantity into quantity_fetched
		from product
		where product_id = t.product_id;
		--checking if quantity of product in cart is greater than availability
		if t.quantity > quantity_fetched then
			dbms_output.put_line('Quantity of product with ID : '||t.product_id||' exceeds availability');
			dbms_output.put_line('Current availability = '||quantity_fetched);
			flag:=1;
		end if;
	end loop;
	if flag = 0 then
		--fetching wallet and total_cost
		select wallet into wallet_fetched
		from customer
		where username=global.username;
		select total_cost into total_cost_fetched
		from cart
		where cart_id in (select cart_id from customer where username=global.username);
		--checking if total cost of cart is greater than amount in wallet
		if total_cost_fetched>wallet_fetched then
			dbms_output.put_line('Payment failed. Insufficient balance in wallet');
			dbms_output.put_line('Total cost of all items in cart : '||total_cost_fetched);
			show_balance;
		else 
			--fetch customer id and cart id
			select customer_id,cart_id into customer_id_fetched,cart_id_fetched
			from customer
			where username=global.username;
			--fetching sysdate
			select sysdate into date_fetched from dual;
			--updating wallet
			update customer
			set wallet = wallet-total_cost_fetched
			where username = global.username;
			dbms_output.put_line('Payment successful');
			show_balance;
			--decreasing availability of products
			for t in (select * from cart_item where cart_id in(select cart_id from customer where username = global.username)) loop
				update product
				set quantity = quantity-t.quantity
				where product_id=t.product_id;
			end loop;
			--delete items from cart
			delete from cart_item
			where cart_id=cart_id_fetched;
			--updating total cost of cart
			update cart
			set total_cost = 0
			where cart_id=cart_id_fetched;
			--creating transaction_id
			select max(transaction_id) into max_transaction_id
			from transaction;
			if max_transaction_id is null then
				new_transaction_id:='trn'||1;
			else
				new_transaction_id:='trn'||(to_number(substr(max_transaction_id,4))+1);
			end if;
			--inserting into transaction table
			insert into transaction values(new_transaction_id,date_fetched,total_cost_fetched,customer_id_fetched,cart_id_fetched);
			dbms_output.put_line('Order placed successfully!');
		end if;
	end if;
exception
	when no_data_found then
		dbms_output.put_line('You are not logged in');
end;
/

create or replace procedure view_category
as
begin
	dbms_output.put_line('ALL CATEGORIES AVAILABLE :- '||chr(10));
	dbms_output.put_line(rpad('CATEGORY_ID',11,' ')||' | '||rpad('CATEGORY_NAME',20,' '));
	dbms_output.put_line('---------------------------------------------------------------------------------------------');
	for t in (select * from category) loop
		dbms_output.put_line(rpad(t.category_id,11,' ')||' | '||rpad(t.category_name,20,' '));
	end loop;
end;
/

create or replace procedure view_brand_in_category
as
	category_name_fetched category.category_name%type;
begin
	select category_name into category_name_fetched
	from category
	where category_id=query.category_id;
	dbms_output.put_line(chr(10)||'ALL BRANDS AVAILABLE IN CATEGORY : '||category_name_fetched||' :-'||chr(10));
	dbms_output.put_line(rpad('BRAND',20,' '));
	dbms_output.put_line('----------------------------------------------------------');
	for t in (select brand from product where category_id=query.category_id) loop
		dbms_output.put_line(rpad(t.brand,20,' '));
	end loop;
end;
/

create or replace procedure view_prod_by_brand_category
as
	category_name_fetched category.category_name%type;
begin
	select category_name into category_name_fetched
	from category
	where category_id=query.category_id;
	dbms_output.put_line(chr(10)||'ALL PRODUCTS AVAILABLE IN CATEGORY : '||category_name_fetched||' and BRAND : '||query.brand||' :-'||chr(10));
	dbms_output.put_line(rpad('PRODUCT_ID',10,' ')||' | '||rpad('PRODUCT_NAME',40,' ')||' | '||rpad('CATEGORY_NAME',20,' ')||' | '||rpad('BRAND',20,' ')||' | '||rpad('PRICE',6,' ')||' | '||rpad('QUANTITY',8,' '));
	dbms_output.put_line('---------------------------------------------------------------------------------------------------------------------------------');
	for t in (select product.product_id,product.product_name,product.brand,product.quantity,product.price,category.category_name from product,category where product.category_id=category.category_id and product.category_id=query.category_id and product.brand=query.brand) loop
		dbms_output.put_line(rpad(t.product_id,10,' ')||' | '||rpad(t.product_name,40,' ')||' | '||rpad(t.category_name,20,' ')||' | '||rpad(t.brand,20,' ')||' | '||rpad(t.price,6,' ')||' | '||rpad(t.quantity,8,' '));
	end loop;
end;
/

create or replace procedure view_prod_by_price_brand_ctg(
	lower_range product.price%type,
	upper_range product.price%type
)
as
	category_name_fetched category.category_name%type;
begin
	select category_name into category_name_fetched
	from category
	where category_id=query.category_id;
	dbms_output.put_line(chr(10)||'ALL PRODUCTS AVAILABLE IN CATEGORY : '||category_name_fetched||' and BRAND : '||query.brand||' and price range : '||lower_range||' to '||upper_range||' :-'||chr(10));
	dbms_output.put_line(rpad('PRODUCT_ID',10,' ')||' | '||rpad('PRODUCT_NAME',40,' ')||' | '||rpad('CATEGORY_NAME',20,' ')||' | '||rpad('BRAND',20,' ')||' | '||rpad('PRICE',6,' ')||' | '||rpad('QUANTITY',8,' '));
	dbms_output.put_line('---------------------------------------------------------------------------------------------------------------------------------');
	for t in (select product.product_id,product.product_name,product.brand,product.quantity,product.price,category.category_name from product,category where product.category_id=category.category_id and product.category_id=query.category_id and product.brand=query.brand and product.price between lower_range and upper_range) loop
		dbms_output.put_line(rpad(t.product_id,10,' ')||' | '||rpad(t.product_name,40,' ')||' | '||rpad(t.category_name,20,' ')||' | '||rpad(t.brand,20,' ')||' | '||rpad(t.price,6,' ')||' | '||rpad(t.quantity,8,' '));
	end loop;
end;
/

create or replace procedure view_cart
as
	grand_total cart.total_cost%type;
begin
	select total_cost into grand_total
	from cart
	where cart_id in(select cart_id from customer where username = global.username);
	dbms_output.put_line('ALL ITEMS IN CART :- '||chr(10));
	dbms_output.put_line(rpad('PRODUCT_ID',10,' ')||' | '||rpad('PRODUCT_NAME',40,' ')||' | '||rpad('CATEGORY_NAME',20,' ')||' | '||rpad('BRAND',20,' ')||' | '||rpad('PRICE',6,' ')||' | '||rpad('QUANTITY',8,' ')||' | '||rpad('TOTAL',7,' '));
	dbms_output.put_line('-----------------------------------------------------------------------------------------------------------------------------------------------');
	for t in (select product.product_id,product.product_name,product.brand,product.price,category.category_name,cart_item.quantity,product.price*cart_item.quantity total from product,cart_item,category where product.product_id=cart_item.product_id and product.category_id=category.category_id and product.product_id in(select product_id from cart_item where (cart_id in (select cart_id from customer where username = global.username)))) loop
		dbms_output.put_line(rpad(t.product_id,10,' ')||' | '||rpad(t.product_name,40,' ')||' | '||rpad(t.category_name,20,' ')||' | '||rpad(t.brand,20,' ')||' | '||rpad(t.price,6,' ')||' | '||rpad(t.quantity,8,' ')||' | '||rpad(t.total,7,' '));
	end loop;
	dbms_output.put_line(chr(10)||'GRAND TOTAL OF ALL ITEMS : '||grand_total);
end;
/
