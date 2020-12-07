set serveroutput on;
declare 
	Name customer.name%type;
	Address customer.address%type;
	Phone_Number customer.phone_number%type;
	Username customer.username%type;
	Password customer.password%type;
begin
	Name := '&Name';
	Address := '&Address';
	Phone_Number := '&Phone_Number';
	Username := '&Username';
	Password := '&Password';
	register(Name,Address,Phone_Number,Username,Password);
end;
/