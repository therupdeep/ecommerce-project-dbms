create or replace procedure register(
	name varchar2,
	address varchar2,
	phone_number number,
	username varchar2,
	password varchar2
) 
as
begin
	for t in (select username,phone_number from customer) loop
	 if username = t.username then
	 	dbms_output.put_line('Enter different Username. This username already exists');
	 end if;
	 if phone_number = t.phone_number then
	 	dbms_output.put_line('Enter different Phone Number. This phone number is taken');
	 end if;
	end loop;
	--set customer id and cart id here
	--insert values into customer table
	dbms_output.put_line('You are successfully registered');
	login(username,password);
end;
/

create or replace procedure login(
    username  varchar2,
    password  varchar2
)
as
begin 
    for t in (select username,password from customer) loop
        if username = t.username and password = t.password then
            dbms_output.put_line('You are logged in');
            return;
        else
            dbms_output.put_line('Login Unsuccessful');
            return;
        end if;
    end loop;
end;
/
