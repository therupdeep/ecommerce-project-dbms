#### Details of all products present in cart

```sql
select product.product_id,product.product_name,product.brand,product.price,category.category_name,cart_item.quantity,product.price*cart_item.quantity total from product,cart_item,category where product.product_id=cart_item.product_id and product.category_id=category.category_id and product.product_id in(select product_id from cart_item where (cart_id in (select cart_id from customer where username = 'user-input')));
```

#### Total Cost of all items in cart 

```sql
select total_cost grand_total from cart where cart_id in(select cart_id from customer where username = 'rupdeep');
```

#### Details of all products between a price range

```sql	
select product.product_id,product.product_name,product.brand,product.quantity,product.price,category.category_name from product,category where product.category_id=category.category_id and product.price between user-input_1 and user-input_2;
```

#### Details of all products less than a particular price and belonging to particular category

```sql
select product.product_id,product.product_name,product.brand,product.quantity,product.price,category.category_name from product,category where product.category_id=category.category_id and product.price<user-input_1 and category.category_name='user-input_2';
```

#### Details of all products of a particular brand

```sql
select product.product_id,product.product_name,product.brand,product.quantity,product.price,category.category_name from Product,category where product.category_id=category.category_id and brand='user-input';
```


