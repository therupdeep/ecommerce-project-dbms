#### Details of all products present in cart

```sql
select product.product_id,product.product_name,product.brand,product.price,cart_item.quantity,product.price*cart_item.quantity total from product,cart_item where product.product_id in(select product_id from cart_item where (cart_id in (select cart_id from customer where username = 'user-input')));
```

#### Total Cost of all items in cart 

```sql
select total_cost grand_total from cart where cart_id in(select cart_id from customer where username = 'user-input');
```

#### Details of all products less than a particular price

```sql	
select * from Product where price<user-input;
```

#### Details of all products less than a particular price and belonging to particular category

```sql
select * from product where price<user-input and category_id in(select category_id from category where category_name='user-input');
```

#### Details of all products of a particular brand

```sql
select * from Product where brand='user-input';
```


