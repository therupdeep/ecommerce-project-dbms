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
            show_balance(username);
            return;
        end if;
    end loop;
    dbms_output.put_line('Login Unsuccessful');
end;
/

create or replace procedure show_balance(
	username1 customer.username%type
)
as 
	balance customer.wallet%type;
begin
	select wallet into balance
	from customer
	where username = username1;
	dbms_output.put_line('Current balance : '||balance);
exception
	when no_data_found then
		dbms_output.put_line('User not found');
end;
/
					
					
create or replace procedure addmoney(
		amount customer.wallet%type,
		username1 customer.username%type
)
as
begin
	update customer
	set wallet = wallet+amount
	where username = username1;
	if sql%rowcount != 1 then
		dbms_output.put_line('User not found');
	else
		dbms_output.put_line('Wallet Updated!');
	end if;
	show_balance(username);	
end; 
/
