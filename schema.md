# Database Schema


## Customer

1. Customer_id(PK)
2. Name
3. Phone_no
4. Address
5. Cart_Id(FK to Cart(Cart_Id))
6. Password
7. Wallet
8. Email_id

## Transaction

1. Transaction_id(PK)
2. Transaction_date
3. Total_Amount
4. Customer_id(FK to Customer(Customer_id))
5. Cart_Id(FK to Cart(Cart_Id))

## Cart

1. Cart_id(PK)
2. Total_cost

## Cart Item

1. Product_Id(PK)(FK to Product(Product_id))
2. Cart_Id(FK to Cart(Cart_Id))
3. Quantity

## Product

1. Product_id(PK)
2. Product_Name
3. Category_id(FK to Category(Category_id))
4. Brand
5. Quantity
6. Price

## Category

1. Category_id(PK)
2. Category_name



