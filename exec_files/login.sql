set serveroutput on;
set linesize 30000;
declare 
	Username customer.username%type;
	Password customer.password%type;
begin
	Username := '&Username';
	Password := '&Password';
	login(Username,Password);
end;
/