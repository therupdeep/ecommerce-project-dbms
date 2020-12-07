set serveroutput on;
accept amount prompt 'Enter the amount you want to add in your wallet : ';
declare
		amount customer.wallet%type;
		username customer.username%type;
begin
   		amount:=&amount;
		username:='&username';
		show_balance(username);
   		addmoney(amount,username);
end;
/
