create or replace procedure register(
	name varchar2,
	address varchar2,
	phone_number number,
	username varchar2,
	password varchar2
) 
is
begin
	for t in (select username,phone_number from customer) loop
	 while username = t.username loop
	 	dbms_output.put_line('Enter different Username. This username already exists');
	 	return;
	 end loop;
	 while phone_number = t.phone_number loop
	 	dbms_output.put_line('Enter different Phone Number. This phone number is taken');
	 	return;
	 end loop;
	end loop;
	--set customer id and cart id here
	--insert values into customer table
	dbms_output.put_line('You are successfully registered');
end;
/