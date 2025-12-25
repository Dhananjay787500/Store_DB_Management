create database store_management;
use store_management;

create table customers (
	customer_id int primary key,
    first_name varchar(200),
    last_name varchar(200),
    phone varchar(30),
    email varchar(200),
    street varchar(200),
    city varchar(30),
    state varchar(30),
    zip_code varchar(30)
);
create table stores (
	store_id int primary key,
    store_name varchar(200),
    phone varchar(25),
    email varchar(200),
    street varchar(200),
    city varchar(200),
    state varchar(30),
    zip_code varchar(30)
);

create table staffs (
	staff_id int primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(200),
    phone varchar(30),
    active int,
    store_id int,
    manager_id int,
    foreign key (store_id) references stores(store_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_status VARCHAR(20),  # Note- you can also use (Enum)
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    store_id INT,
    staff_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (staff_id) REFERENCES staffs(staff_id)
);


create table brands (
	brand_id int primary key,
    brand_name varchar(200)
);

create table categories (
	category_id int primary key,
    category_name varchar(200)
);

create table products (
	product_id int primary key,
    product_name varchar(255),
    brand_id int,
    category_id int,
    model_year int,
    list_price decimal(10,2),
    foreign key (brand_id) references brands(brand_id),
    foreign key (category_id) references categories(category_id)
);

create table order_items (
	order_id int,
    item_id int,
    product_id int,
    quantity int,
    list_price decimal(10,2),
    discount decimal(4,2),
    foreign key (product_id) references products(product_id)
);

create table stocks (
	store_id int,
    product_id int,
    quantity int,
    foreign key (store_id) references stores(store_id),
    foreign key (product_id) references products(product_id)
);

select * from brands;
select * from categories;
select * from customers;
select * from order_items;	
select * from orders; 	
select * from products; 
select * from staffs;	
select * from stocks;		
select * from stores;
