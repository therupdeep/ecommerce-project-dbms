set serveroutput on;
declare 
	Name varchar2(20);
	Address varchar2(20);
	Phone_Number number(10);
	Username varchar2(20);
	Password varchar2(20);
begin
	Name := '&Name';
	Address := '&Address';
	Phone_Number := '&Phone_Number';
	Username := '&Username';
	Password := '&Password';
	register(Name,Address,Phone_Number,Username,Password);
end;
/