set serveroutput on;
accept product_id prompt 'Enter the product_id of the product you want to add : ';
declare
	product_id cart_item.product_id%type;
	Quantity cart_item.quantity%type;
begin
	product_id:='&product_id';
	Quantity:=&Quantity;
	add_to_cart(product_id,Quantity);
end;
/



