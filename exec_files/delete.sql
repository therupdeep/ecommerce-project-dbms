set serveroutput on;

declare
	product_id customer.product_id%type;
	quantity customer.quantity%type;
begin
	product_id:='&product_id';
	quantity:=&quantity;
	delete(product_id,quantity);
end;
/
