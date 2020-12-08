create or replace package global as
	username customer.username%type;
end global;
/

create or replace procedure register(
	name customer.name%type,
	address customer.address%type,
	phone_number customer.phone_number%type,
	username customer.username%type,
	password customer.password%type
) 
is
	flag integer:=0;
	new_customer_id customer.customer_id%type;
	new_cart_id customer.cart_id%type;
	max_customer_id customer.customer_id%type;
	max_cart_id customer.cart_id%type;
begin
	for t in (select username,phone_number from customer) loop
	 if username = t.username then
	 	dbms_output.put_line('Enter different Username. This username already exists');
	 	flag:=1;
	 end if;
	 if phone_number = t.phone_number then
	 	dbms_output.put_line('Enter different Phone Number. This phone number is taken');
	 	flag:=1;
	 end if;
	 if flag = 1 then
	 	return;
	 end if;
	end loop;
	select max(customer_id),max(cart_id) into max_customer_id,max_cart_id
	from customer;
	if max_customer_id is null then
		new_customer_id:='cst'||1;
		new_cart_id:='crt'||1;
	else
		new_customer_id:='cst'||(to_number(substr(max_customer_id,3))+1);
		new_cart_id:='crt'||(to_number(substr(max_cart_id,3))+1);
	end if;
	insert into cart values(new_cart_id,0);
	insert into customer values(new_customer_id,name,address,phone_number,username,password,0,new_cart_id);
	dbms_output.put_line('You are successfully registered');
	login(username,password);
end;
/

create or replace procedure login(
    username customer.username%type,
	password customer.password%type
)
as
begin 
    for t in (select username,password from customer) loop
        if username = t.username and password = t.password then
            dbms_output.put_line('You are logged in');
            global.username := username;
            show_balance;
            return;
        end if;
    end loop;
    dbms_output.put_line('Login Unsuccessful');
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
	when no_data_found then
		dbms_output.put_line('User not found');
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
	if sql%rowcount != 1 then
		dbms_output.put_line('User not found');
	else
		dbms_output.put_line('Wallet Updated!');
	end if;
	show_balance;	
end; 
/

create or replace procedure add_to_cart(
	product_id_input cart_item.product_id%type,
	quantity_input cart_item.quantity%type
)
as
	flag integer:=0;
	cart_id_fetched cart_item.cart_id%type;
	price_fetched product.price%type;
begin
	--fetching cart_id of the current customer
	select cart_id into cart_id_fetched
	from customer
	where username = global.username;
	--fetching price of product to be added
	select price into price_fetched
	from product
	where product_id = product_id_input;
	for t in (select product_id from cart_item where cart_id=cart_id_fetched) loop
		--checking if product already exists in cart. If yes we increase quantity
		if product_id_input = t.product_id then
			update cart_item
			set quantity=quantity+quantity_input
			where product_id = product_id_input and cart_id = cart_id_fetched;
			flag=0;
			exit;
		else 
			flag:=1;
		end if;
	end loop;
	--if product is not present in cart
	if flag = 1 then
		insert into cart_item values(product_id_input,quantity_input,cart_id_fetched);
	end if;
	--updating total cost of the cart items
	update cart
	set total_cost=total_cost+price_fetched*quantity_input
	where cart_id = cart_id_fetched;
exception
	when no_data_found then
		dbms_output.put_line('User not found');
end;
/

create or replace procedure delete_from_cart(
	    product_id_input cart_item.product_id%type;
	    quantity_input cart_item.quantity%type;
)
as
	flag integer:=0;
	cart_id_fetched cart_item.cart_id%type;
	quantity_fetched cart_item.quantity%type;
	price_fetched product.price%type;
begin
	--fetching cart_id of the current customer
	select cart_id into cart_id_fetched
	from customer
	where username = global.username;
	for t in (select product_id from cart_item where cart_id=cart_id_fetched) loop
		--checking if product exists in cart
		if product_id_input = t.product_id then
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
			end if;
			flag=0;
			exit;
		else 
			flag:=1;
		end if;
	end loop;
	--if product is not present in cart
	if flag = 1 then
		dbms_output.put_line('Product to be deleted is not added to cart');
	end if;
exception
	when no_data_found then
		dbms_output.put_line('User not found');
end;
/
