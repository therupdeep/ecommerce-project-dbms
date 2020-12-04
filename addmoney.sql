set serveroutput on;
declare
		money number;
begin
		dbms_output.put_line('Add the amount');
   		money:='&money';
   		addmoney(money);
end;
/
