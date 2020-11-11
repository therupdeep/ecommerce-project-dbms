# ERD Changes :-


### Note : In designing ERD and implementing it we have to take care of minimum number of attributes and appropriate foreign keys. Therefore I decided to make the following changes accordingly:-



## Customer

1. Customer_id(PK)
2. Name
3. Phone_no
4. Address
5. Cart_Id(FK to Cart(Cart_Id))

## Transaction

1. Transaction_id(PK)
2. Transaction_date
3. Total_Amount
4. Customer_id(FK to Customer)
5. Cart_Id(FK to Cart(Cart_Id))

## Cart

1. Cart_id(PK)
2. Total_cost

## Cart Item

1. Product_Id(PK)(FK to Product)
2. Cart_Id(FK to Cart(Cart_Id))
3. Quantity

## Product

1. Product_id(PK)
2. Product_Name
3. Category_id(FK to Category)
4. Brand
5. Quantity
6. Price

## Category

1. Category_id(PK)
2. Category_name



