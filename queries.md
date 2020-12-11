1. Details of all products present in cart

```sql
	select * from product where product_id in(select product_id from cart_item where (cart_id in (select cart_id from customer where username = 'user-input')));
```

2. Total_cost of all items in cart 

```sql
	select total_cost from cart where cart_id in(select cart_id from customer where username = 'user-input');
```

3. Details of all products less than a particular price

```sql	
	select * from Product where price<'user-input';
```

4. Details of all products less than a particular price and belonging to particular category

```sql
	select * from product where price<'user-input' and category_id in(select category_id from category where category_name='user-input');
```

5. Details of all products of a particular brand

```sql
	select * from Product where brand='user-input';
```


