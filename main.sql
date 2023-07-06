-- create restaurant.db 
-- create 5 table
-- write down 5x query 1 with clause, 1 subquery , 1 aggregate functiON + join
.open restuarant.db
DROP TABLE menu;
DROP TABLE order_list;
DROP TABLE customer;
DROP TABLE payment;
DROP TABLE payment_type;

CREATE TABLE menu (
  menu_id INT,
  menu_name TEXT,
  unit_price INT 
);

.mode column
.header ON

INSERT INTO menu VALUES 
(1,"Cat Kapow",90),
(2,"Alpaca Spaghetti",150),
(3,"Grilled Goat",190),
(4,"Lamp soup",120),
(5,"Horse salad",70);

CREATE TABLE order_list (
  order_id INT,
  order_date TEXT ,
  customer_id INT,
  menu_id INT
);

INSERT INTO order_list VALUES
  (99,"2023-01-01",21,5),
  (98,"2023-01-02",25,3),
  (97,"2023-01-03",28,1),
  (96,"2023-01-01",23,1),
  (95,"2023-01-05",22,4),
  (94,"2023-01-01",27,5),
  (93,"2023-01-01",23,3),
  (92,"2023-01-03",20,1),
  (91,"2023-01-01",23,4),
  (90,"2023-01-04",24,2);

CREATE TABLE customer(
  customer_id INT,
  Fname TEXT,
  Lname TEXT,
  phone INT
);


INSERT INTO customer VALUES
  (20,"Parth","Danielsen",8232719967),
  (21,"Yamato","Yi",2995662521),
  (22,"Mentor","Lazzari",2114850287),
  (23,"Jago","Koch",3909414521),
  (24,"Vugar","Kovac",3509369795),
  (25,"ArdaliON","Prunty",5776662550),
  (26,"Pooja","Kranz",4239433628),
  (27,"Naa","Xiao",3735973560),
  (28,"Triinu","Santiago",7204119506),
  (29,"Finlay","SimeONov",5012151697);

CREATE TABLE payment (
  payment_id INT,
  customer_id INT,
  order_id INT,
  payment_date TEXT,
  payment_code TEXT,
  amount INT 
);

INSERT INTO payment VALUES 
  (311,21,99,"2023-01-01","CSH",70),
  (312,22,95,"2023-01-05","CSH",120),
  (313,23,96,"2023-01-01","IB",90),
  (314,23,93,"2023-01-01","IB",190),
  (315,23,91,"2023-01-01","IB",120),
  (316,24,90,"2023-01-04","DEB",150),
  (317,25,98,"2023-01-02","IB",190),
  (318,27,94,"2023-01-01","CSH",70),
  (319,28,97,"2023-01-03","IB",90);

CREATE TABLE payment_type (
  payment_code TEXT,
  payment_categ TEXT
);

INSERT INTO payment_type VALUES 
  ("CSH","Cash"),
  ("IB","Internet Banking"),
  ("DEB","Debit Card");

-- you can writing query to increase price here
/*UPDATE menu 
  SET unit_price = 90 --change unit price
  WHERE  menu_id = 1;*/ --change menu id (1-5)



.print "         "
.print "          "
.print "**Order Detail**"
.print "         "

  
  SELECT
  menu.menu_id,
  menu.menu_name,
  order_list.order_id,
  order_list.customer_id,
  menu.unit_price || "$" AS 'unit price',
  order_list.order_date
FROM order_list JOIN menu 
ON menu.menu_id = order_list.menu_id
  ORDER BY menu.unit_price DESC;
--
.print "        "
.print "        "
.print "**Revenue by each Menu**"
.print "        "
  WITH rev_sale_menu AS (WITH rev_menu1 AS (SELECT
  sum(OD.unit_price) || "$" rev_menu1,
  menu_name menu_1
  FROM (
  SELECT 
  menu.menu_id,
  menu.menu_name,
  order_list.order_id,
  order_list.customer_id,
  menu.unit_price,
  order_list.order_date
FROM order_list JOIN menu 
ON menu.menu_id = order_list.menu_id) AS OD
  WHERE OD.menu_id = 1),

    rev_menu2 AS (SELECT 
  sum(OD.unit_price) || "$" rev_menu2,
  menu_name menu_2
  FROM (
  SELECT 
  menu.menu_id,
  menu.menu_name,
  order_list.order_id,
  order_list.customer_id,
  menu.unit_price,
  order_list.order_date
FROM order_list JOIN menu 
ON menu.menu_id = order_list.menu_id) AS OD
  WHERE OD.menu_id = 2),

    rev_menu3 AS (SELECT
  sum(OD.unit_price) || "$" rev_menu3,
  menu_name menu_3
  FROM (
  SELECT 
  menu.menu_id,
  menu.menu_name,
  order_list.order_id,
  order_list.customer_id,
  menu.unit_price,
  order_list.order_date
FROM order_list JOIN menu 
ON menu.menu_id = order_list.menu_id) AS OD
  WHERE OD.menu_id = 3),

    rev_menu4 AS (SELECT 
  sum(OD.unit_price) || "$" rev_menu4,
  menu_name menu_4
  FROM (
  SELECT 
  menu.menu_id,
  menu.menu_name,
  order_list.order_id,
  order_list.customer_id,
  menu.unit_price,
  order_list.order_date
FROM order_list JOIN menu 
ON menu.menu_id = order_list.menu_id) AS OD
  WHERE OD.menu_id = 4),

    rev_menu5 AS (SELECT 
  sum(OD.unit_price) || "$" rev_menu5,
  menu_name menu_5
  FROM (
  SELECT 
  menu.menu_id,
  menu.menu_name,
  order_list.order_id,
  order_list.customer_id,
  menu.unit_price,
  order_list.order_date
FROM order_list JOIN menu 
ON menu.menu_id = order_list.menu_id) AS OD
  WHERE OD.menu_id = 5)

    SELECT *
FROM rev_menu1,rev_menu2,
  rev_menu3,rev_menu4,rev_menu5)

SELECT *
  FROM rev_sale_menu;


.print "         "
.print "          "

--which menu is best seller?
.print "**Sale by each Menu**"
.print "           "
WITH quan_sale_menu AS (WITH sale_menu5 AS (
  SELECT 
  count(menu.menu_id) AS menu_5_sale,
  menu_name menu_5
FROM order_list JOIN menu 
ON menu.menu_id = order_list.menu_id
WHERE menu.menu_id = 5)

,sale_menu4 AS (
  SELECT 
  count(menu.menu_id) AS menu_4_sale,
  menu_name menu_4
FROM order_list JOIN menu 
ON menu.menu_id = order_list.menu_id
WHERE menu.menu_id = 4)

,sale_menu3 AS (
  SELECT 
  count(menu.menu_id) AS menu_3_sale,
  menu_name menu_3
FROM order_list JOIN menu 
ON menu.menu_id = order_list.menu_id
WHERE menu.menu_id = 3)

,sale_menu2 AS (
  SELECT  
  count(menu.menu_id) AS menu_2_sale,
  menu_name menu_2
FROM order_list JOIN menu 
ON menu.menu_id = order_list.menu_id
WHERE menu.menu_id = 2)

,sale_menu1 AS (
  SELECT 
  count(menu.menu_id) AS menu_1_sale,
  menu_name menu_1
FROM order_list JOIN menu 
ON menu.menu_id = order_list.menu_id
WHERE menu.menu_id = 1)

SELECT *
FROM sale_menu1,sale_menu2,
  sale_menu3,sale_menu4,sale_menu5)

SELECT *
  FROM quan_sale_menu;

.print "     "
.print "**Payment Details**"
.print "       "
  
SELECT 
  p.*,pt.payment_categ,
  ct.Fname || " " || ct.Lname  AS "payer"
  
FROM payment AS p 
  JOIN payment_type AS pt
  ON p.payment_code = pt.payment_code
  JOIN customer AS ct 
  ON p.customer_id = ct.customer_id;

.print "    "
.print "     "
.print "**Payment Type Counting**"
.print "       "

WITH payment_count AS (WITH IB_count AS (SELECT count(payment_code) AS IB_count,
  payment_categ type1
  FROM
  (SELECT 
  p.*,pt.payment_categ
FROM payment AS p 
  JOIN payment_type AS pt
  ON p.payment_code = pt.payment_code
  JOIN customer AS ct 
  ON p.customer_id = ct.customer_id)
WHERE payment_code = 'IB'),

CSH_count AS (SELECT count(payment_code) AS CSH_count,
  payment_categ type2
  FROM
  (SELECT 
  p.*,pt.payment_categ
FROM payment AS p 
  JOIN payment_type AS pt
  ON p.payment_code = pt.payment_code
  JOIN customer AS ct 
  ON p.customer_id = ct.customer_id)
WHERE payment_code = 'CSH'),

DEB_count AS (SELECT count(payment_code) AS DEB_count,
  payment_categ type3
  FROM
  (SELECT 
  p.*,pt.payment_categ
FROM payment AS p 
  JOIN payment_type AS pt
  ON p.payment_code = pt.payment_code
  JOIN customer AS ct 
  ON p.customer_id = ct.customer_id)
WHERE payment_code = 'DEB')

SELECT * 
FROM IB_count, CSH_count, DEB_count)

SELECT *
FROM payment_count;



-- find who is the most spender
--date
.print "    "
.print "     "
.print "**Customer Spending Details**"
.print "       "
SELECT 

  STRFTIME('%Y',payment_date) AS year,
  STRFTIME('%m',payment_date) AS month,
  STRFTIME('%d',payment_date) AS day,
  ct.Fname || " " || ct.Lname AS 'Full Name',
  amount || "$" AS 'revenue',
  p.customer_id,
  order_id
  
FROM payment AS p 
  JOIN payment_type AS pt
  ON p.payment_code = pt.payment_code
  JOIN customer AS ct 
  ON p.customer_id = ct.customer_id
GROUP BY order_id
;
.print "    "
.print "     "
.print "**ex. search customer_id 24**"
.print "       "
  
SELECT *
FROM 
  (SELECT 
  STRFTIME('%Y',payment_date) AS year,
  STRFTIME('%m',payment_date) AS month,
  STRFTIME('%d',payment_date) AS day,
  ct.Fname || " " || ct.Lname AS 'Full Name',
  amount || "$" AS 'revenue',
  p.customer_id,
  order_id
  
FROM payment AS p 
  JOIN payment_type AS pt
  ON p.payment_code = pt.payment_code
  JOIN customer AS ct 
  ON p.customer_id = ct.customer_id
GROUP BY order_id
)
WHERE customer_id = 24; --write you filter query here