-- PostgreSQL demo: fictional customers, orders and order items
DROP TABLE IF EXISTS demo_order_items;
DROP TABLE IF EXISTS demo_orders;
DROP TABLE IF EXISTS demo_products;
DROP TABLE IF EXISTS demo_customers;

CREATE TABLE demo_customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name TEXT NOT NULL
);
CREATE TABLE demo_products (
  product_id INTEGER PRIMARY KEY,
  product_name TEXT NOT NULL
);
CREATE TABLE demo_orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL REFERENCES demo_customers(customer_id),
  order_date DATE NOT NULL
);
CREATE TABLE demo_order_items (
  order_id INTEGER NOT NULL REFERENCES demo_orders(order_id),
  product_id INTEGER NOT NULL REFERENCES demo_products(product_id),
  quantity INTEGER NOT NULL CHECK (quantity > 0),
  unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
  PRIMARY KEY (order_id, product_id)
);

INSERT INTO demo_customers VALUES (1,'Customer A'),(2,'Customer B'),(3,'Customer C');
INSERT INTO demo_products VALUES (10,'Notebook'),(20,'Pen Set'),(30,'Planner');
INSERT INTO demo_orders VALUES
 (100,1,'2026-01-05'),(101,2,'2026-01-12'),(102,1,'2026-02-03'),
 (103,3,'2026-02-20'),(104,2,'2026-02-22');
INSERT INTO demo_order_items VALUES
 (100,10,2,12.00),(100,20,1,8.00),(101,30,1,18.00),
 (102,10,1,12.00),(102,30,2,18.00),(103,20,3,8.00),
 (104,10,1,12.00),(104,20,2,8.00);
