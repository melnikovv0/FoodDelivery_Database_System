-- Dropping existing foreign key constraints
ALTER TABLE ORDER_DETAILS DROP CONSTRAINT ord_det_order_fk;
ALTER TABLE ORDER_DETAILS DROP CONSTRAINT ord_det_food_fk;
ALTER TABLE PAYMENT DROP CONSTRAINT pay_order_fk;
ALTER TABLE ORDERS DROP CONSTRAINT ord_user_fk;
ALTER TABLE ORDERS DROP CONSTRAINT ord_courier_fk;
ALTER TABLE ORDERS DROP CONSTRAINT ord_restaurant_fk;
ALTER TABLE MENU DROP CONSTRAINT men_restaurant_fk;
ALTER TABLE FOOD DROP CONSTRAINT foo_menu_fk;

-- Dropping tables
DROP TABLE ORDER_DETAILS CASCADE CONSTRAINTS;
DROP TABLE PAYMENT CASCADE CONSTRAINTS;
DROP TABLE ORDERS CASCADE CONSTRAINTS;
DROP TABLE USERY CASCADE CONSTRAINTS;
DROP TABLE RESTAURANT CASCADE CONSTRAINTS;
DROP TABLE COURIER CASCADE CONSTRAINTS;
DROP TABLE MENU CASCADE CONSTRAINTS;
DROP TABLE FOOD CASCADE CONSTRAINTS;
DROP TABLE PROMOTION CASCADE CONSTRAINTS;
DROP TABLE DISCOUNT_CODES CASCADE CONSTRAINTS;

-- Creating tables
CREATE TABLE USERY (
    id_user     NUMBER NOT NULL,
    email       VARCHAR2(50) NOT NULL,
    name        VARCHAR2(20) NOT NULL,
    surname     VARCHAR2(20) NOT NULL,
    city        VARCHAR2(20) NOT NULL,
    country     VARCHAR2(30) NOT NULL,
    phone       VARCHAR2(12) NOT NULL,
    last_visit  DATE NOT NULL,
    role        CHAR(1) NOT NULL,
    CONSTRAINT us_user_pk PRIMARY KEY (id_user)
);

CREATE TABLE RESTAURANT (
    id_restaurant  NUMBER NOT NULL,
    name           VARCHAR2(50) NOT NULL,
    address        VARCHAR2(100) NOT NULL,
    contact_info   VARCHAR2(50) NOT NULL,
    description    CLOB NOT NULL,
    CONSTRAINT res_pk PRIMARY KEY (id_restaurant)
);

CREATE TABLE COURIER (
    id_courier NUMBER NOT NULL,
    name       VARCHAR2(50) NOT NULL,
    surname    VARCHAR2(50) NOT NULL,
    phone      VARCHAR2(12) NOT NULL,
    CONSTRAINT cou_pk PRIMARY KEY (id_courier)
);

CREATE TABLE ORDERS (
    id_order       NUMBER NOT NULL,
    id_user        NUMBER NOT NULL,
    id_courier     NUMBER,
    id_restaurant  NUMBER NOT NULL,
    order_details  CLOB,
    status         VARCHAR2(50) NOT NULL,
    start_time     TIMESTAMP NOT NULL,
    end_time       TIMESTAMP NOT NULL,
    price          NUMBER(10, 2) NOT NULL,
    CONSTRAINT ord_pk PRIMARY KEY (id_order),
    CONSTRAINT ord_user_fk FOREIGN KEY (id_user) REFERENCES USERY (id_user),
    CONSTRAINT ord_courier_fk FOREIGN KEY (id_courier) REFERENCES COURIER (id_courier),
    CONSTRAINT ord_restaurant_fk FOREIGN KEY (id_restaurant) REFERENCES RESTAURANT (id_restaurant)
);

CREATE TABLE MENU (
    id_menu        NUMBER NOT NULL,
    id_restaurant  NUMBER NOT NULL,
    CONSTRAINT men_pk PRIMARY KEY (id_menu),
    CONSTRAINT men_restaurant_fk FOREIGN KEY (id_restaurant) REFERENCES RESTAURANT (id_restaurant)
);

CREATE TABLE FOOD1 (
    id_food    NUMBER NOT NULL,
    id_menu    NUMBER NOT NULL,
    dish_name  VARCHAR2(50) NOT NULL,
    price      NUMBER(10, 2) NOT NULL,
    CONSTRAINT foo_pk PRIMARY KEY (id_food),
    CONSTRAINT foo_menu_fk FOREIGN KEY (id_menu) REFERENCES MENU (id_menu)
);

CREATE TABLE ORDER_DETAILS (
    id_order_details        NUMBER NOT NULL,
    id_order                NUMBER NOT NULL,
    id_food                 NUMBER NOT NULL,
    quantity                NUMBER NOT NULL,
    price_at_time_of_order  NUMBER(10, 2) NOT NULL,
    CONSTRAINT ord_det_pk PRIMARY KEY (id_order_details),
    CONSTRAINT ord_det_order_fk FOREIGN KEY (id_order) REFERENCES ORDERS (id_order),
    CONSTRAINT ord_det_food_fk FOREIGN KEY (id_food) REFERENCES FOOD1 (id_food)
);

CREATE TABLE DISCOUNT_CODES (
    id_discount_code   NUMBER NOT NULL,
    code               VARCHAR2(20) NOT NULL,
    description        CLOB NOT NULL,
    discount_percent   NUMBER(5, 2) NOT NULL,
    valid_from         DATE NOT NULL,
    valid_to           DATE NOT NULL,
    CONSTRAINT discount_code_pk PRIMARY KEY (id_discount_code)
);

CREATE TABLE PAYMENT (
    id_payment      NUMBER NOT NULL,
    id_order        NUMBER NOT NULL,
    payment_method  VARCHAR2(50) NOT NULL,
    payment_status  VARCHAR2(50) NOT NULL,
    payment_date    TIMESTAMP NOT NULL,
    amount          NUMBER(10, 2) NOT NULL,
    CONSTRAINT pay_pk PRIMARY KEY (id_payment),
    CONSTRAINT pay_order_fk FOREIGN KEY (id_order) REFERENCES ORDERS (id_order)
);

CREATE TABLE PROMOTION (
    id_promotion      NUMBER NOT NULL,
    promotion_name    VARCHAR2(50) NOT NULL,
    description       CLOB NOT NULL,
    start_date        DATE NOT NULL,
    end_date          DATE NOT NULL,
    discount_percent  NUMBER(5, 2) NOT NULL,
    CONSTRAINT pro_pk PRIMARY KEY (id_promotion)
);

-- Inserting data
INSERT ALL
    INTO USERY (id_user, email, name, surname, city, country, phone, last_visit, role) VALUES (1, 'john@example.com', 'John', 'Doe', 'New York', 'USA', '123-456-7890', TO_DATE('2023-12-04', 'YYYY-MM-DD'), 'U')
    INTO USERY (id_user, email, name, surname, city, country, phone, last_visit, role) VALUES (2, 'jane@example.com', 'Jane', 'Smith', 'Los Angeles', 'USA', '987-654-3210', TO_DATE('2023-12-04', 'YYYY-MM-DD'), 'U')
    INTO USERY (id_user, email, name, surname, city, country, phone, last_visit, role) VALUES (3, 'mike@example.com', 'Mike', 'Johnson', 'Chicago', 'USA', '555-555-5555', TO_DATE('2023-12-04', 'YYYY-MM-DD'), 'U')
    INTO USERY (id_user, email, name, surname, city, country, phone, last_visit, role) VALUES (4, 'emily@example.com', 'Emily', 'Brown', 'Houston', 'USA', '111-111-1111', TO_DATE('2023-12-04', 'YYYY-MM-DD'), 'U')
    INTO USERY (id_user, email, name, surname, city, country, phone, last_visit, role) VALUES (5, 'david@example.com', 'David', 'Wilson', 'Miami', 'USA', '222-222-2222', TO_DATE('2023-12-04', 'YYYY-MM-DD'), 'U')
SELECT * FROM dual;

INSERT ALL
    INTO RESTAURANT (id_restaurant, name, address, contact_info, description) VALUES (1, 'Red Grill', '123 Main St', '123-456-7890', 'A great place for steaks')
    INTO RESTAURANT (id_restaurant, name, address, contact_info, description) VALUES (2, 'Mama Pizzeria', '456 Elm St', '987-654-3210', 'Authentic Italian pizza')
    INTO RESTAURANT (id_restaurant, name, address, contact_info, description) VALUES (3, 'Sushi Palace', '789 Oak St', '555-123-4567', 'Fresh sushi and sashimi')
    INTO RESTAURANT (id_restaurant, name, address, contact_info, description) VALUES (4, 'La Fiesta', '321 Pine St', '444-555-6666', 'Spicy Mexican flavors')
    INTO RESTAURANT (id_restaurant, name, address, contact_info, description) VALUES (5, 'Café Paris', '567 Maple St', '111-222-3333', 'French cuisine in town')
SELECT * FROM dual;

INSERT ALL
    INTO COURIER (id_courier, name, surname, phone) VALUES (1, 'John', 'Doe', '123-456-7890')
    INTO COURIER (id_courier, name, surname, phone) VALUES (2, 'Jane', 'Smith', '987-654-3210')
    INTO COURIER (id_courier, name, surname, phone) VALUES (3, 'Mike', 'Johnson', '555-555-5555')
    INTO COURIER (id_courier, name, surname, phone) VALUES (4, 'Emily', 'Brown', '111-111-1111')
    INTO COURIER (id_courier, name, surname, phone) VALUES (5, 'David', 'Wilson', '222-222-2222')
SELECT * FROM dual;

INSERT ALL
    INTO ORDERS (id_order, id_user, id_courier, id_restaurant, order_details, status, start_time, end_time, price) VALUES (1, 1, 1, 1, 'Steak', 'In Progress', TO_TIMESTAMP('2023-12-04 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-04 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 500.00)
    INTO ORDERS (id_order, id_user, id_courier, id_restaurant, order_details, status, start_time, end_time, price) VALUES (2, 2, 2, 1, 'Caesar Salad', 'Delivered', TO_TIMESTAMP('2023-12-04 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-04 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 150.00)
    INTO ORDERS (id_order, id_user, id_courier, id_restaurant, order_details, status, start_time, end_time, price) VALUES (3, 3, 3, 3, 'Sashimi', 'In Progress', TO_TIMESTAMP('2023-12-04 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-04 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 400.00)
    INTO ORDERS (id_order, id_user, id_courier, id_restaurant, order_details, status, start_time, end_time, price) VALUES (4, 4, 4, 4, 'Tacos', 'Delivered', TO_TIMESTAMP('2023-12-04 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-04 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), 200.00)
    INTO ORDERS (id_order, id_user, id_courier, id_restaurant, order_details, status, start_time, end_time, price) VALUES (5, 5, 5, 2, 'Margherita Pizza', 'In Progress', TO_TIMESTAMP('2023-12-04 10:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-04 12:15:00', 'YYYY-MM-DD HH24:MI:SS'), 250.00)
SELECT * FROM dual;

INSERT ALL
    INTO MENU (id_menu, id_restaurant) VALUES (1, 1)
    INTO MENU (id_menu, id_restaurant) VALUES (2, 2)
    INTO MENU (id_menu, id_restaurant) VALUES (3, 3)
    INTO MENU (id_menu, id_restaurant) VALUES (4, 4)
    INTO MENU (id_menu, id_restaurant) VALUES (5, 5)
SELECT * FROM dual;

INSERT ALL
    INTO FOOD1 (id_food, id_menu, dish_name, price) VALUES (1, 1, 'Steak', 500.00)
    INTO FOOD1 (id_food, id_menu, dish_name, price) VALUES (2, 1, 'Caesar Salad', 150.00)
    INTO FOOD1 (id_food, id_menu, dish_name, price) VALUES (3, 2, 'Margherita Pizza', 250.00)
    INTO FOOD1 (id_food, id_menu, dish_name, price) VALUES (4, 2, 'Pepperoni Pizza', 300.00)
    INTO FOOD1 (id_food, id_menu, dish_name, price) VALUES (5, 3, 'Sushi Nigiri', 350.00)
SELECT * FROM dual;

INSERT ALL
    INTO ORDER_DETAILS (id_order_details, id_order, id_food, quantity, price_at_time_of_order) VALUES (1, 1, 1, 1, 500.00)
    INTO ORDER_DETAILS (id_order_details, id_order, id_food, quantity, price_at_time_of_order) VALUES (2, 2, 2, 1, 150.00)
    INTO ORDER_DETAILS (id_order_details, id_order, id_food, quantity, price_at_time_of_order) VALUES (3, 3, 3, 1, 250.00)
    INTO ORDER_DETAILS (id_order_details, id_order, id_food, quantity, price_at_time_of_order) VALUES (4, 4, 4, 1, 300.00)
    INTO ORDER_DETAILS (id_order_details, id_order, id_food, quantity, price_at_time_of_order) VALUES (5, 5, 5, 1, 350.00)
SELECT * FROM dual;

INSERT ALL
    INTO DISCOUNT_CODES (id_discount_code, code, description, discount_percent, valid_from, valid_to) VALUES (1, 'WINTER20', 'Winter Sale - 20% off', 20.00, TO_DATE('2023-12-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'))
    INTO DISCOUNT_CODES (id_discount_code, code, description, discount_percent, valid_from, valid_to) VALUES (2, 'NY2024', 'New Year Special - 15% off', 15.00, TO_DATE('2023-12-25', 'YYYY-MM-DD'), TO_DATE('2024-01-05', 'YYYY-MM-DD'))
    INTO DISCOUNT_CODES (id_discount_code, code, description, discount_percent, valid_from, valid_to) VALUES (3, 'LOVE10', 'Valentine''s Day Offer - 10% off', 10.00, TO_DATE('2024-02-10', 'YYYY-MM-DD'), TO_DATE('2024-02-14', 'YYYY-MM-DD'))
SELECT * FROM dual;

INSERT ALL
    INTO PAYMENT (id_payment, id_order, payment_method, payment_status, payment_date, amount) VALUES (1, 1, 'Credit Card', 'Completed', TO_TIMESTAMP('2023-12-04 12:05:00', 'YYYY-MM-DD HH24:MI:SS'), 500.00)
    INTO PAYMENT (id_payment, id_order, payment_method, payment_status, payment_date, amount) VALUES (2, 2, 'PayPal', 'Completed', TO_TIMESTAMP('2023-12-04 13:05:00', 'YYYY-MM-DD HH24:MI:SS'), 150.00)
    INTO PAYMENT (id_payment, id_order, payment_method, payment_status, payment_date, amount) VALUES (3, 3, 'Credit Card', 'Pending', TO_TIMESTAMP('2023-12-04 12:35:00', 'YYYY-MM-DD HH24:MI:SS'), 400.00)
SELECT * FROM dual;

INSERT ALL
    INTO PROMOTION (id_promotion, promotion_name, description, start_date, end_date, discount_percent) VALUES (1, 'Winter Sale', 'Get 20% off on all orders during the winter season', TO_DATE('2023-12-01', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), 20.00)
    INTO PROMOTION (id_promotion, promotion_name, description, start_date, end_date, discount_percent) VALUES (2, 'New Year Special', 'Celebrate the New Year with a 15% discount on all food items', TO_DATE('2023-12-25', 'YYYY-MM-DD'), TO_DATE('2024-01-05', 'YYYY-MM-DD'), 15.00)
    INTO PROMOTION (id_promotion, promotion_name, description, start_date, end_date, discount_percent) VALUES (3, 'Valentine''s Day Offer', 'Enjoy a romantic dinner with a 10% discount on all orders', TO_DATE('2024-02-10', 'YYYY-MM-DD'), TO_DATE('2024-02-14', 'YYYY-MM-DD'), 10.00)
SELECT * FROM dual;

-- SQL S01 L01: String Functions
SELECT LOWER(name), UPPER(name), INITCAP(name) FROM USERY;
SELECT CONCAT(name, ' ', surname) AS full_name FROM USERY;
SELECT SUBSTR(email, 1, 5) FROM USERY;
SELECT LENGTH(name) FROM USERY;
SELECT INSTR(email, '@') FROM USERY;
SELECT LPAD(name, 10, '*') FROM USERY;
SELECT RPAD(name, 10, '*') FROM USERY;
SELECT TRIM(' ' FROM name) FROM USERY;
SELECT REPLACE(name, 'a', '@') FROM USERY;
SELECT * FROM DUAL;

-- SQL S01 L02: Numeric Functions
SELECT ROUND(price, 2), TRUNC(price, 2), MOD(price, 100) FROM ORDERS;

-- SQL S01 L03: Date Functions
SELECT 
    MONTHS_BETWEEN(SYSDATE, DATE '2023-01-01') AS months_between,
    ADD_MONTHS(SYSDATE, 1) AS add_months,
    NEXT_DAY(SYSDATE, 2) AS next_monday,  
    LAST_DAY(SYSDATE) AS last_day_of_month,
    ROUND(SYSDATE, 'MONTH') AS round_to_month,
    TRUNC(SYSDATE, 'MONTH') AS trunc_to_month
FROM DUAL;

-- SQL S02 L01: Conversion Functions
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD'), TO_NUMBER('12345'), TO_DATE('2023-01-01', 'YYYY-MM-DD') 
FROM DUAL;

-- SQL S02 L02: Null Functions
SELECT NVL(phone, 'N/A'), NVL2(phone, 'Has Phone', 'No Phone'), NULLIF(role, 'U'), COALESCE(phone, 'N/A') 
FROM USERY;

-- SQL S02 L03: Conditional Expressions
SELECT DECODE(role, 'U', 'User', 'A', 'Admin', 'C', 'Courier', 'Unknown')
FROM USERY;
SELECT CASE WHEN role = 'U' THEN 'User' WHEN role = 'A' THEN 'Admin' WHEN role = 'C' THEN 'Courier' ELSE 'Unknown' END 
FROM USERY;

-- SQL S03 L01: Joins
SELECT * FROM USERY NATURAL JOIN ORDERS;
SELECT * FROM USERY CROSS JOIN ORDERS;

-- SQL S03 L02: Joins with USING and ON
SELECT * FROM USERY JOIN ORDERS USING(id_user);
SELECT * FROM USERY JOIN ORDERS ON USERY.id_user = ORDERS.id_user;

-- SQL S03 L03: Outer Joins
SELECT * FROM USERY LEFT OUTER JOIN ORDERS ON USERY.id_user = ORDERS.id_user;
SELECT * FROM USERY RIGHT OUTER JOIN ORDERS ON USERY.id_user = ORDERS.id_user;
SELECT * FROM USERY FULL OUTER JOIN ORDERS ON USERY.id_user = ORDERS.id_user;



ALTER TABLE USERY ADD parent_user_id NUMBER;

UPDATE USERY SET parent_user_id = NULL WHERE id_user = 1;
UPDATE USERY SET parent_user_id = 1 WHERE id_user IN (2, 3);
UPDATE USERY SET parent_user_id = 2 WHERE id_user = 4;
UPDATE USERY SET parent_user_id = 3 WHERE id_user = 5;

-- SQL S03 L04: Hierarchical Queries
SELECT name, surname, LEVEL 
FROM USERY 
START WITH parent_user_id IS NULL 
CONNECT BY PRIOR id_user = parent_user_id;

-- SQL S04 L02: Aggregation Functions
SELECT AVG(price), COUNT(*), MIN(price), MAX(price), SUM(price), VARIANCE(price), STDDEV(price) FROM ORDERS;

-- SQL S04 L03: COUNT and NVL
SELECT COUNT(*), COUNT(DISTINCT id_user), NVL(SUM(price), 0) FROM ORDERS;

-- SQL S05 L01: GROUP BY and HAVING
SELECT id_restaurant, COUNT(*) FROM ORDERS GROUP BY id_restaurant HAVING COUNT(*) > 1;

-- SQL S05 L02: ROLLUP, CUBE
SELECT id_restaurant, id_courier, COUNT(*) FROM ORDERS GROUP BY ROLLUP(id_restaurant, id_courier);
SELECT id_restaurant, id_courier, COUNT(*) FROM ORDERS GROUP BY CUBE(id_restaurant, id_courier);

-- SQL S05 L03: Set Operations
SELECT name FROM RESTAURANT UNION SELECT name FROM COURIER;
SELECT name FROM RESTAURANT INTERSECT SELECT name FROM COURIER;
SELECT name FROM RESTAURANT MINUS SELECT name FROM COURIER;

-- SQL S06 L01: Nested Queries
SELECT * FROM ORDERS WHERE id_user IN (SELECT id_user FROM USERY WHERE city = 'New York');

-- SQL S06 L02: Single-Value Subqueries
SELECT * FROM ORDERS WHERE price = (SELECT MAX(price) FROM ORDERS);

-- SQL S06 L03: Multi-Value Subqueries
SELECT * FROM ORDERS WHERE id_user IN (SELECT id_user FROM USERY WHERE country = 'USA');

-- SQL S06 L04: WITH Clause
WITH order_totals AS (
    SELECT id_user, SUM(price) AS total_spent FROM ORDERS GROUP BY id_user
)
SELECT * FROM order_totals;

-- SQL S07 L01: Insert Statements
INSERT INTO USERY (id_user, email, name, surname, city, country, phone, last_visit, role) VALUES (6, 'alice@example.com', 'Alice', 'Wonder', 'Wonderland', 'Fantasy', '333-333-3333', SYSDATE, 'U');

-- SQL S07 L02: Update and Delete Statements
UPDATE USERY SET city = 'Los Angeles' WHERE id_user = 1;
DELETE FROM USERY WHERE id_user = 6;

-- SQL S07 L03: MERGE Statement
MERGE INTO USERY u USING (SELECT 1 AS id_user, 'admin@example.com' AS email, 'Admin' AS name, 'User' AS surname, 'NY' AS city, 'USA' AS country, '000-000-0000' AS phone, SYSDATE AS last_visit, 'A' AS role FROM dual) src ON (u.id_user = src.id_user)
WHEN MATCHED THEN UPDATE SET u.email = src.email, u.name = src.name, u.surname = src.surname, u.city = src.city, u.country = src.country, u.phone = src.phone, u.last_visit = src.last_visit, u.role = src.role
WHEN NOT MATCHED THEN INSERT (u.id_user, u.email, u.name, u.surname, u.city, u.country, u.phone, u.last_visit, u.role) VALUES (src.id_user, src.email, src.name, src.surname, src.city, src.country, src.phone, src.last_visit, src.role);

-- SQL S08 L01: Database Objects
CREATE INDEX idx_user_city ON USERY(city);
CREATE VIEW user_view AS SELECT id_user, name, surname FROM USERY;
CREATE SEQUENCE user_seq START WITH 1 INCREMENT BY 1;

-- SQL S08 L02: Timestamps and Intervals
SELECT CURRENT_TIMESTAMP, SYSTIMESTAMP, (SYSTIMESTAMP - INTERVAL '1' DAY) FROM DUAL;

-- SQL S08 L03: Alter and Drop Statements
ALTER TABLE USERY ADD (nickname VARCHAR2(20));
DROP TABLE USERY;

-- SQL S10 L01: Constraints
CREATE TABLE test_constraints (
    id NUMBER PRIMARY KEY,
    value VARCHAR2(50) UNIQUE,
    status CHAR(1) NOT NULL CHECK (status IN ('A', 'I')),
    ref_id NUMBER,
    CONSTRAINT fk_ref FOREIGN KEY (ref_id) REFERENCES USERY(id_user)
);

-- SQL S10 L02: User Constraints
SELECT * FROM user_constraints WHERE table_name = 'USER';

-- SQL S11 L01: Create View
CREATE VIEW user_comments AS SELECT u.name, u.surname, c.text FROM USERY u JOIN COMMENTS c ON u.id_user = c.user_id;

-- SQL S11 L03: Inline Views
SELECT * FROM (SELECT * FROM USERY WHERE ROWNUM <= 5);

-- SQL S12 L01: Sequences
CREATE SEQUENCE order_seq START WITH 1 INCREMENT BY 1;

-- SQL S12 L02: Indexes
CREATE INDEX idx_order_price ON ORDERS(price);

-- SQL S13 L01: Grants and Revokes
GRANT SELECT ON USERY TO PUBLIC;
REVOKE SELECT ON USERY FROM PUBLIC;

-- SQL S13 L03: Regular Expressions
SELECT * FROM USERY WHERE REGEXP_LIKE(email, '^[a-z0-9._%+-]+@[a-z0-9.-]+.[a-z]{2,}$');

-- SQL S14 L01: Transactions
INSERT INTO USERY (id_user, email, name, surname, city, country, phone, last_visit, role) VALUES (7, 'bob@example.com', 'Bob', 'Builder', 'Builder City', 'Construction', '444-444-4444', SYSDATE, 'U');
COMMIT;
ROLLBACK;

-- SQL S15 L01: Alternative Joins
SELECT * FROM USERY u, ORDERS o WHERE u.id_user = o.id_user;

-- Recap
SELECT * FROM USERY;