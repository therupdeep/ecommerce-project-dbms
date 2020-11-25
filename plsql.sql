declare 
	name varchar2(20);
	address varchar2(20);
	phone_number number(10);
	username varchar2(20);
	password varchar2(20);
	password_table varchar2(20);
	username_table varchar2(20);
begin
	name := '&name';
	address := '&address';
	phone_number := '&phone_number';
	username := '&username';
	password := '&password';
	select username,password into username_table, password_table
	from customer
	while username = username_table loop
		username := '&username';
	while password = password_table loop
		password := '&password';
end;
/

