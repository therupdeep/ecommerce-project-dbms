set serveroutput on;
set linesize 3000;
accept email_id prompt 'Enter a valid email_id : ';
accept phone_number prompt 'Enter a valid phone number : ';
accept password prompt 'Enter a password of atleast 7 characters with a mixture of letters and numbers : ';
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
