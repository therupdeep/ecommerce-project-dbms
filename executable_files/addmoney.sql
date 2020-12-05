set serveroutput on;
accept money customer.wallet%type prompt 'Enter the amount you want to add in your wallet';
declare
		money customer.wallet%type;
		username customer.username%type;
begin
   		money:='&money';
		username:='&username';
		show_balance(username);
   		addmoney(money,username);
end;
/
