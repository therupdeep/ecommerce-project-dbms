set serveroutput on;
declare
		money customer.wallet%type;
		username customer.username%type;
begin
   		money:='&money';
		username:='&username';
   		addmoney(money,username);
end;
/
