set serveroutput on;
declare
		money customer.wallet%type;
begin
   		money:='&money';
   		addmoney(money,username);
end;
/
