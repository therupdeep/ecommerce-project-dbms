create table Cart 
(
	cart_id varchar(7) constraint pk1 primary key,
	total_cost number(7)
);

create table Customer
(
    customer_id varchar(7) constraint pk2 primary key,
    name varchar(30) not null,
    address varchar(40) not null,
    phone_number number(10) not null,
    username varchar(20) not null,
    password varchar(20) not null,
    wallet number(7) not null,
    cart_id varchar(7) not null constraint fk1 references Cart(cart_id)
);

create table Transaction
(
    transaction_id varchar(7) constraint pk3 primary key,
    transaction_date date not null,
    total_amount number(7),
    customer_id varchar(7) not null constraint fk2 references Customer(customer_id),
    cart_id varchar(7) not null constraint fk3 references Cart(cart_id)
);

create table Category
(
	category_id varchar(7) constraint pk4 primary key,
	category_name varchar(40) not null
);

create table Product
(
    product_id varchar(7) constraint pk5 primary key,
    product_name varchar(40) not null,
    brand varchar(30) not null,
    quantity number(2) not null,
    price number(6) not null,
    category_id varchar(7) not null constraint fk4 references Category(category_id)
);

create table Cart_Item
(
    product_id varchar(7) constraint pk6 primary key constraint fk5 references Product(product_id),
    quantity number(2) not null,
    cart_id varchar(7) not null constraint fk6 references Cart(cart_id)
);


insert into Category values('ctg1','Laptops');
insert into Category values('ctg2','Watches');
insert into Category values('ctg3','Books');
insert into Category values('ctg4','Home and Kitchen');
insert into Category values('ctg5','Baby Products');
insert into Category values('ctg6','Sports');
insert into Category values('ctg7','Office Supplies');
insert into Category values('ctg8','Home Entertainment');
insert into Category values('ctg9','Travel Accessories');


insert into Product values('prod1','Notebook14','MI',10,43999,'ctg1');
insert into Product values('prod2','ZenBook','ASUS',10,269295,'ctg1');
insert into Product values('prod3','Inspiron','DELL',10,26990,'ctg1');
insert into Product values('prod4','IdeaPad','Lenovo',10,30999,'ctg1');
insert into Product values('prod5','MacBook Air','Apple',10,66490,'ctg1');
insert into Product values('prod6','VivoBook14','ASUS',10,35990,'ctg1');
insert into Product values('prod7','Run Tiger','SKMEI',10,485,'ctg2');
insert into Product values('prod8','Smart Band','MI',10,2099,'ctg2');
insert into Product values('prod9','Chronograph','Fossil',10,7645,'ctg2');
insert into Product values('prod10','Georgia','Fossil',10,4547,'ctg2');
insert into Product values('prod11','Neo','Titan',10,3395,'ctg2');
insert into Product values('prod12','Collider Hybrid','Fossil',10,14995,'ctg2');
insert into Product values('prod13','Concise Physics','Selina',10,367,'ctg3');
insert into Product values('prod14','Total History and Civics','Morning Star',10,310,'ctg3');
insert into Product values('prod15','Harry Potter and the Philosopher"s Stone by J.K. Rowling','Bloomsbury',10,367,'ctg3');
insert into Product values('prod16','Emotional Intelligence by Daniel Goleman','Bloomsbury',10,499,'ctg3');
insert into Product values('prod17','To Skies and Waters by Sirjandeep Kaur Ubha','Rupa',10,419,'ctg3');
insert into Product values('prod18','Train Your Brain by Shireen Stephen','Rupa',10,295,'ctg3');
insert into Product values('prod19','Electric Kettle','Pigeon',10,699,'ctg4');
insert into Product values('prod20','Induction Cooktop','Prestige',10,1689,'ctg4');
insert into Product values('prod21','Sandwich Maker','Prestige',10,1200,'ctg4');
insert into Product values('prod22','Cookware Induction Base','Cello',10,1599,'ctg4');
insert into Product values('prod23','Dinner Set','Cello',10,1049,'ctg4');
insert into Product values('prod24','Mixer Grinder','Bajaj',10,1849,'ctg4');
insert into Product values('prod25','Baby Lotion','Himalaya',10,199,'ctg5');
insert into Product values('prod26','Ceregrow','Nestle',10,249,'ctg5');
insert into Product values('prod27','Lactogen','Nestle',10,330,'ctg5');
insert into Product values('prod28','Diapers','MamyPoko',10,351,'ctg5');
insert into Product values('prod29','Wonder Pants','Huggies',10,713,'ctg5');
insert into Product values('prod30','Baby Cream','Himalaya',10,189,'ctg5');
insert into Product values('prod31','Tennis Ball (Pack of 10)','Goldiluxe',10,229,'ctg6');
insert into Product values('prod32','Stumps','Fallyn',10,510,'ctg6');
insert into Product values('prod33','Storm Football','Nivia',10,379,'ctg6');
insert into Product values('prod34','Headband','Skudgear',10,399,'ctg6');
insert into Product values('prod35','Excercise Mat','Gocar',10,1049,'ctg6');
insert into Product values('prod36','Protein Powder','Goldiluxe',10,229,'ctg6');
insert into Product values('prod37','Butterflow Pen','Cello',10,76,'ctg7');
insert into Product values('prod38','Notebook','Classmate',10,102,'ctg7');
insert into Product values('prod39','Calculator','Orpat',10,159,'ctg7');
insert into Product values('prod40','Scientific Calculator','Casio',10,500,'ctg7');
insert into Product values('prod41','Magnetic White Board','Nechams',10,699,'ctg7');
insert into Product values('prod42','Folder','OFIXO',10,149,'ctg7');
insert into Product values('prod43','DVD Player','iBell',10,2290,'ctg8');
insert into Product values('prod44','Soundbar','FD',10,999,'ctg8');
insert into Product values('prod45','Led Projector','Egate',10,8990,'ctg8');
insert into Product values('prod46','Smart TV','OnePlus',10,24999,'ctg8');
insert into Product values('prod47','Home Theater','Vemax',10,1590,'ctg8');
insert into Product values('prod48','Android Led TV','Mi',10,22499,'ctg8');
insert into Product values('prod49','Searchlight','Care 4',10,649,'ctg9');
insert into Product values('prod50','Mask','The Upfront Co.',10,500,'ctg9');
insert into Product values('prod51','Shoe Bag','Shoeshine',10,299,'ctg9');
insert into Product values('prod52','Umbrella','John"s Umbrella',10,399,'ctg9');
insert into Product values('prod53','Cosmetics kit','Fatmug',10,699,'ctg9');
insert into Product values('prod54','Eye Mask','Mediwave',10,350,'ctg9');
