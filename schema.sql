create table Cart 
(
	cart_id varchar(7) constraint pk1 primary key,
	total_cost number(6)
);

create table Customer
(
    customer_id varchar(7) constraint pk2 primary key,
    name varchar(20) not null,
    address varchar(20) not null,
    phone_number number(10) not null,
    username varchar(20) not null,
    password varchar(20) not null,
    wallet number(6) not null,
    cart_id varchar(7) not null constraint fk1 references Cart(cart_id)
);

create table Transaction
(
    transaction_id varchar(7) constraint pk3 primary key,
    transaction_date date not null,
    total_amount number(6),
    customer_id varchar(7) not null constraint fk2 references Customer(customer_id),
    cart_id varchar(7) not null constraint fk3 references Cart(cart_id)
);

create table Category
(
	category_id varchar(7) constraint pk4 primary key,
	category_name varchar(20) not null
);

create table Product
(
    product_id varchar(7) constraint pk5 primary key,
    product_name varchar(20) not null,
    brand varchar(20) not null,
    quantity number(2) not null,
    price number(5) not null,
    category_id varchar(7) not null constraint fk4 references Category(category_id)
);

create table Cart_Item
(
    product_id varchar(7) constraint pk6 primary key constraint fk5 references Product(product_id),
    quantity number(1) not null,
    cart_id varchar(7) not null constraint fk6 references Cart(cart_id)
);


insert into Category values
(
	'ctg1','Laptops'
);
insert into Category values
(
	'ctg2','Watches'
);
insert into Category values
(
	'ctg3','Books'
);
insert into Category values
(
	'ctg4','Home & Kitchen'
);
insert into Category values
(
	'ctg5','Baby Products'
);
insert into Category values
(
	'ctg6','Sports'
);
insert into Category values
(
	'ctg7','Office Suplies'
);
insert into Category values
(
	'ctg8','Home Entertainment'
);
insert into Category values
(
	'ctg9','Travel Accessories'
);
insert into Category values
(
	'ctg10','Home Entertainment'
);
