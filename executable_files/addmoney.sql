set serveroutput on;
accept amount number prompt 'Enter the amount you want to add in your wallet';
declare
		amount number;
		username customer.username%type;
begin
   		amount:=&amount;
		username:='&username';
		show_balance(username);
   		addmoney(money,username);
end;
/
