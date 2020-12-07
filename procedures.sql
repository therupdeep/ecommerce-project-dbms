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
	if sql%rowcount != 1 then
		dbms_output.put_line('User not found');
	else
		dbms_output.put_line('Wallet Updated!');
	end if;
	show_balance;	
end; 
/

create or replace procedure add_to_cart(
	product_id1 cart_item.product_id%type,
	quantity1 cart_item.quantity%type
)
as
	cart_id cart_item.cart_id%type;
begin
	select cart_id into cart_id
	from customer
	where username = global.username;
	if product_id in (select product_id from cart_item) then
		update cart_item
		set quantity=quantity+quantity1;
		where product_id = product_id1;
	else
		insert into cart_item values(product_id1,quantity1,cart_id);
exception
	when no_data_found then
		dbms_output.put_line('User not found');
end;
/

create or replace procedure delete(
	    product_id customer.product_id%type;
	    quantity customer.quantity%type;)
as
 		flag integer:=0;
begin
		for t in(select product_id from product) loop
			if product_id != t.product_id then
				flag:=1;
			end if;
		end loop;
		for i in(select quantity from product) loop
			if quantity<i.quantity then
				flag :=1;
			end if;
		end loop;
		if flag=1 then
			dbms_output.put_line("Either product_id or quantity mentioned is invalid");
		else 
			for i in(select quantity from product) loop
				if quantity=i.quantity then
					delete from cart_item
					where product_id=product_id;
				else if quantity>i.quantity then
					delete from cart_item
					where quantity=i.quantity;
				end if;
				dbms_output.put_line("Deleted Successfully");
			end loop;
		end if;
end;
