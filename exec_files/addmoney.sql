set serveroutput on;
accept amount prompt 'Enter the amount you want to add in your wallet : ';
declare
		amount customer.wallet%type;
begin
   		amount:=&amount;
		show_balance;
   		addmoney(amount);
end;
/
