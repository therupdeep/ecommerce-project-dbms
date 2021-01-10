set serveroutput on;
set linesize 3000;
exec view_category;
accept category_id prompt 'Enter the category_id of the category you want to select : ';
declare
	category_id category.category_id%type;
begin
	category_id:='&category_id';
	query.category_id:=category_id;
	view_brand;
end;
/
declare
	brand product.brand%type;
begin
	brand:='&brand';
	query.brand:=brand;
	view_product_by_brand;
end;
/
declare
	lower_range product.price%type;
	upper_range product.price%type;
begin
	lower_range:='&lower_range';
	upper_range:='&upper_range';
	view_product_by_price(lower_range,upper_range);
end;
/
