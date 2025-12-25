# 4. Functional Requirements
# 4.1 Stores Management

-- Maintain a list of store locations.
select store_name, street, city, state, zip_code
from stores;

-- Capture store details: Name, phone, email, address, city, state, and zip codes
select store_name, phone, email, street, city, state, zip_code
from stores;

# 4.2 Staff Management

-- Store employee details, including first name, last name, email, and phone.
select first_name, last_name, email, phone 
from staffs;

-- Associate staff with stores.
select stf.*, str.*
from staffs as stf
inner join stores as str
on stf.store_id = str.store_id;

-- Track managers by linking staff to other staff members.
select e.staff_id as employee_id, concat(e.first_name, ' ', e.last_name) as employee_name, concat(m.first_name, ' ', m.last_name) as manager_name
from staffs e
left join staffs m
on e.manager_id = m.staff_id;

-- Maintain active status for employees.
select staff_id, concat(first_name, ' ', last_name),
	case
		when active = 1 then 'Active'
        else 'Inactive'
	end as Employee_Status
    from staffs;

# 4.3 Product Management
-- Maintain product details, including name, brand, category, model year, and list price.
select P.product_name, B.brand_name, C.category_name, P.model_year, P.list_price
from products as P
join brands as B
on P.brand_id = B.brand_id
join categories as C
on P.category_id = C.category_id;

-- Categorize products by category and brand.
select P.product_name, C.category_name, B.brand_name
from products as P
join categories as C
on P.category_id = C.category_id
join brands as B
on B.brand_id = P.brand_id;

# 4.4 Customer Management
-- Store customer details such as name, phone, email, and address.
select first_name, last_name, phone, email, street as address
from customers;

# 4.5 Order Management
-- Capture customer orders with order status, order date, required date, and shipped date.
select order_status, order_date, required_date, shipped_date
from orders;

-- Associate orders with customers, staff, and stores.
select O.order_id, C.first_name as customer_name, E.first_name as employee_name, S.store_name, O.order_status, O.order_date
from orders as O
join customers as C
on O.customer_id = C.customer_id
join staffs as E
on O.staff_id = E.staff_id
join stores as S
on O.store_id = S.store_id;

-- Track individual order items, including product, quantity, list price, and discounts.
select P.product_name, Ot.quantity, Ot.list_price, Ot.discount
from products as P
right join order_items as Ot
on P.product_id = Ot.product_id;

# 4.6 Inventory Management
-- Maintain stock levels for each product at each store location.
select * from stocks;
select P.product_name, S.city as location, St.quantity
from products as P
join stocks as St
on P.product_id = St.product_id
join stores as S
on S.store_id = St.store_id;

-- Track the quantity of products available per store
select * from stocks;
select S.store_name, P.product_name, Sk.quantity
from stocks as Sk
join stores as S
on S.store_id = Sk.store_id
join products as P
on Sk.product_id = P.product_id
order by store_name, product_name;

# 5. Data Model
# 5.1 Tables
# Stores Table
-- The stores table includes the store’s information. 
-- Each store has a store name, contact information such as phone and email, and an address including street, city, state, and zip code.
select * from stores;

# Staffs Table
-- The staffs table stores the essential information of staffs including first name, last name.
-- It also contains the communication information such as email and phone.
select * from staffs;

-- A staff works at a store specified by the value in the store_id column.
-- A store can have one or more staffs.
select * from staffs; 

-- A staff reports to a store manager specified by the value in the manager_id column. If the
-- value in the manager_id is null, then the staff is the top manager.
select staff_id, first_name, email, manager_id
from staffs
where manager_id is null;
----------------------------------------------------------------------------------------
					-- Alternative 
select s.staff_id, s.first_name as staff_name,
coalesce(m.first_name, 'Top Manger') as Manager_name
from staffs s
left join staffs m
on s.manager_id = m.staff_id;
	
-- If a staff no longer works for any stores, the value in the active column is set to zero.
select * from staffs;
select staff_id, first_name, store_id,
case
	when store_id is null then 'Inacitve'
    else 'Active'
end Employee_status
from staffs;
-----------------------------------------------------------
				# Alternative
update staffs
set active = 0
where store_id is null;
select * from staffs;

# Categories Table
-- The categories table stores the bike’s categories such as children bicycles, comfort
-- bicycles, and electric bikes.
select * from categories;

# Brands Table
-- The brands table stores the brand’s information of bikes, for example, Electra, Haro, and Heller.
select * from brands;

# Products Table
-- The products table stores the product’s information such as name, brand, category, model year, and list price.
select * from products;

-- Each product belongs to a brand specified by the brand_id column. Hence, a brand may have zero or many products.
select product_name, brand_id
from products;

-- Each product also belongs a category specified by the category_id column. Also, each category may have zero or many products.
select * from products;

# Customers Table
-- The customers table stores customer’s information including first name, last name, phone, email, street, city, state and zip code.
select * from customers;

# Order Table
-- The orders table stores the sales order’s header information including customer, order status, order date, required date, shipped date.
select * from orders;

-- It also stores the information on where the sales transaction was created (store) and who created it (staff).
select S.store_name, S.street, S.city
from stores as S
join staffs as St
on St.store_id = S.store_id;

-- Each sales order has a row in the sales_orders table. A sales order has one or many line items stored in the order_items table.
select * from order_items;

# Order_Items Table
-- The order_items table stores the line items of a sales order. Each line item belongs to a sales order specified by the order_id column.
select * from order_items;

-- A sales order line item includes product, order quantity, list price, and discount. 
select * from order_items;

# Stocks Table
-- The stocks table stores the inventory information i.e. the quantity of a particular product in a specific store.
select * from stocks;