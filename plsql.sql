declare 
	name varchar2(20);
	address varchar2(20);
	phone_number number(10);
	username varchar2(20);
	password varchar2(20);
begin
	--enter custom strings like "Enter name" , etc. for every following input
	name := '&name';
	address := '&address';
	phone_number := &phone_number;
	username := '&username';
	password := '&password';
	for t in (select username,phone_number from customer) loop
	 while username = t.username loop
	 	--insert custom string "Username is taken plz enter different username"
	 	username := '&username';
	 end loop;
	 while phone_number = t.phone_number loop
	 	--insert custom string "Phone Number is taken plz enter different phone number"
	 	phone_number := &phone_number;
	 end loop;
	end loop;
	--insert into table customer the new values and print successfully registered
end;
/

