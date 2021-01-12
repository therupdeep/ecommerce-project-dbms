set serveroutput on;
set linesize 3000;
declare 
	Email_id customer.email_id%type;
	Password customer.password%type;
begin
	Email_id := '&Email_id';
	Password := '&Password';
	login(Email_id,Password);
end;
/
