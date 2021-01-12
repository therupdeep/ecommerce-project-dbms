set serveroutput on;
set linesize 3000;
accept Email_id prompt 'Enter a valid Email Address : ';
accept Phone_Number prompt 'Enter a 10 digit Phone Number : ';
accept Password prompt 'Enter a password of atleast 6 characters and maximum 10 characters : ';
declare 
	Name customer.name%type;
	Address customer.address%type;
	Email_id customer.email_id%type;
	Phone_Number customer.phone_number%type;
	Password customer.password%type;
begin
	Name := '&Name';
	Address := '&Address';
	Email_id := '&Email_id';
	Phone_Number := '&Phone_Number';
	Password := '&Password';
	register(Name,Address,Email_id,Phone_Number,Password);
end;
/
