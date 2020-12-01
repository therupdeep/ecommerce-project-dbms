set serveroutput on;
declare 
	Username varchar2(20);
	Password varchar2(20);
begin
	Username := '&Username';
	Password := '&Password';
	login(Username,Password);
end;
/