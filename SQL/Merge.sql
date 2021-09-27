insert into customers_new VALUES ('NEW001', 'New', 'New', '', '');
insert into customers_new VALUES ('OLD002', 'New', 'New', '', '');
insert into customers_new VALUES ('NEW003', 'New', 'New', '', '');
insert into customers_new VALUES ('OLD004', 'New', 'New', '', '');
insert into customers_new VALUES ('NEW005', 'New', 'New', '', '');

insert into customers_new_1 VALUES ('NEW001', 'New 1', 'New 1', '', '');
insert into customers_new_1 VALUES ('OLD002', 'New 1', 'New 1', '', '');
insert into customers_new_1 VALUES ('NEW003', 'New 1', 'New 1', '', '');
insert into customers_new_1 VALUES ('OLD004', 'New 1', 'New 1', '', '');
insert into customers_new_1 VALUES ('NEW005', 'New 1', 'New 1', '', '');

select * from customers_new ORDER BY customer_new_id;
delete from customers_new;

select * from customers_new_1 ORDER BY customer_new_id;
delete from customers_new_1;

--1) 1:1
MERGE INTO customers_new n
    USING customers_old o
    ON (n.CUSTOMER_NEW_ID = o.CUSTOMER_OLD_ID)
    WHEN MATCHED THEN
        UPDATE SET 
            n.CUSTOMER_NEW_NAME = o.CUSTOMER_OLD_NAME,
            n.CITY = o.CITY,
            n.UPDATE_DATE = SYSDATE,
            n.MODE_INSERT = 'UPDATE'
    WHEN NOT MATCHED THEN
        INSERT (n.CUSTOMER_NEW_ID, n.CUSTOMER_NEW_NAME, n.CITY, n.UPDATE_DATE, n.MODE_INSERT)
        VALUES (o.CUSTOMER_OLD_ID, o.CUSTOMER_OLD_NAME, o.CITY, SYSDATE, 'INSERT');
    
-- 2) n :1Tr??ng h?p các Table chuy?n giao không có quan h? v?i nhau?
MERGE INTO customers_new n
    USING customers_old o
    ON (n.CUSTOMER_NEW_ID = o.CUSTOMER_OLD_ID)
    WHEN MATCHED THEN
        UPDATE SET 
            n.CUSTOMER_NEW_NAME = o.CUSTOMER_OLD_NAME,
            n.CITY = o.CITY,
            n.UPDATE_DATE = SYSDATE,
            n.MODE_INSERT = 'UPDATE'
    WHEN NOT MATCHED THEN
        INSERT (n.CUSTOMER_NEW_ID, n.CUSTOMER_NEW_NAME, n.CITY, n.UPDATE_DATE, n.MODE_INSERT)
        VALUES (o.CUSTOMER_OLD_ID, o.CUSTOMER_OLD_NAME, o.CITY, SYSDATE, 'INSERT');
------------------------------------------
MERGE INTO customers_new n
    USING customers_old_1 o1
    ON (n.CUSTOMER_NEW_ID = o1.CUSTOMER_OLD_ID)
    WHEN MATCHED THEN
        UPDATE SET 
            n.CUSTOMER_NEW_NAME = o1.CUSTOMER_OLD_NAME,
            n.CITY = o1.CITY,
            n.UPDATE_DATE = SYSDATE,
            n.MODE_INSERT = 'UPDATE'
    WHEN NOT MATCHED THEN
        INSERT (n.CUSTOMER_NEW_ID, n.CUSTOMER_NEW_NAME, n.CITY, n.UPDATE_DATE, n.MODE_INSERT)
        VALUES (o1.CUSTOMER_OLD_ID, o1.CUSTOMER_OLD_NAME, o1.CITY, SYSDATE, 'INSERT');
        
-- 3)  n :1Tr??ng h?p get item c?a Table ?ích chuy?n ??i t? nhi?u Table chuy?n giao?
-- INNER JOIN
MERGE INTO customers_new n
    USING (
    SELECT 
        o.CUSTOMER_OLD_ID AS CUSTOMER_OLD_ID,
        o.CUSTOMER_OLD_NAME AS CUSTOMER_OLD_NAME,
        o2.CITY AS CITY
    FROM
        customers_old o INNER JOIN customers_old_2 o2
        ON o.customer_old_id = o2.customer_old_id
    ) TBL
    ON (n.CUSTOMER_NEW_ID = TBL.CUSTOMER_OLD_ID)
    WHEN MATCHED THEN
        UPDATE SET 
            n.CUSTOMER_NEW_NAME = TBL.CUSTOMER_OLD_NAME,
            n.CITY = TBL.CITY,
            n.UPDATE_DATE = SYSDATE,
            n.MODE_INSERT = 'UPDATE'
    WHEN NOT MATCHED THEN
        INSERT (n.CUSTOMER_NEW_ID, n.CUSTOMER_NEW_NAME, n.CITY, n.UPDATE_DATE, n.MODE_INSERT)
        VALUES (TBL.CUSTOMER_OLD_ID, TBL.CUSTOMER_OLD_NAME, TBL.CITY, SYSDATE, 'INSERT');
        
-- LEFT JOIN
MERGE INTO customers_new n
    USING (
    SELECT 
        o.CUSTOMER_OLD_ID AS CUSTOMER_OLD_ID,
        o.CUSTOMER_OLD_NAME AS CUSTOMER_OLD_NAME,
        o2.CITY AS CITY
    FROM
        customers_old o LEFT JOIN customers_old_2 o2
        ON o.customer_old_id = o2.customer_old_id
    ) TBL
    ON (n.CUSTOMER_NEW_ID = TBL.CUSTOMER_OLD_ID)
    WHEN MATCHED THEN
        UPDATE SET 
            n.CUSTOMER_NEW_NAME = TBL.CUSTOMER_OLD_NAME,
            n.CITY = TBL.CITY,
            n.UPDATE_DATE = SYSDATE,
            n.MODE_INSERT = 'UPDATE'
    WHEN NOT MATCHED THEN
        INSERT (n.CUSTOMER_NEW_ID, n.CUSTOMER_NEW_NAME, n.CITY, n.UPDATE_DATE, n.MODE_INSERT)
        VALUES (TBL.CUSTOMER_OLD_ID, TBL.CUSTOMER_OLD_NAME, TBL.CITY, SYSDATE, 'INSERT');
        
-- RIGHT JION
MERGE INTO customers_new n
    USING (
    SELECT 
        o2.CUSTOMER_OLD_ID AS CUSTOMER_OLD_ID,
        o2.CUSTOMER_OLD_NAME AS CUSTOMER_OLD_NAME,
        o.CITY AS CITY
    FROM
        customers_old o RIGHT JOIN customers_old_2 o2
        ON o.customer_old_id = o2.customer_old_id
    ) TBL
    ON (n.CUSTOMER_NEW_ID = TBL.CUSTOMER_OLD_ID)
    WHEN MATCHED THEN
        UPDATE SET 
            n.CUSTOMER_NEW_NAME = TBL.CUSTOMER_OLD_NAME,
            n.CITY = TBL.CITY,
            n.UPDATE_DATE = SYSDATE,
            n.MODE_INSERT = 'UPDATE'
    WHEN NOT MATCHED THEN
        INSERT (n.CUSTOMER_NEW_ID, n.CUSTOMER_NEW_NAME, n.CITY, n.UPDATE_DATE, n.MODE_INSERT)
        VALUES (TBL.CUSTOMER_OLD_ID, TBL.CUSTOMER_OLD_NAME, TBL.CITY, SYSDATE, 'INSERT');
        
-- 4) 1:n  Tr??ng h?p chia ra thành nhi?u Table ?ích chuy?n ??i r?i th?c hi?n chuy?n ??i
MERGE INTO customers_new n
    USING customers_old o
    ON (n.CUSTOMER_NEW_ID = o.CUSTOMER_OLD_ID)
    WHEN MATCHED THEN
        UPDATE SET 
            n.CUSTOMER_NEW_NAME = o.CUSTOMER_OLD_NAME,
            n.CITY = o.CITY,
            n.UPDATE_DATE = SYSDATE,
            n.MODE_INSERT = 'UPDATE'
    WHEN NOT MATCHED THEN
        INSERT (n.CUSTOMER_NEW_ID, n.CUSTOMER_NEW_NAME, n.CITY, n.UPDATE_DATE, n.MODE_INSERT)
        VALUES (o.CUSTOMER_OLD_ID, o.CUSTOMER_OLD_NAME, o.CITY, SYSDATE, 'INSERT');
------------------------------------------------
MERGE INTO customers_new_1 n1
    USING customers_old o
    ON (n1.CUSTOMER_NEW_ID = o.CUSTOMER_OLD_ID)
    WHEN MATCHED THEN
        UPDATE SET 
            n1.CUSTOMER_NEW_NAME = o.CUSTOMER_OLD_NAME,
            n1.CITY = o.CITY,
            n1.UPDATE_DATE = SYSDATE,
            n1.MODE_INSERT = 'UPDATE'
    WHEN NOT MATCHED THEN
        INSERT (n1.CUSTOMER_NEW_ID, n1.CUSTOMER_NEW_NAME, n1.CITY, n1.UPDATE_DATE, n1.MODE_INSERT)
        VALUES (o.CUSTOMER_OLD_ID, o.CUSTOMER_OLD_NAME, o.CITY, SYSDATE, 'INSERT');

--5) 1:n Tr??ng h?p chuy?n ??i theo set ??i v?i TBL có quan h? parent-child
-- 5-1) Tr??ng h?p ko có ?ánh s? sequence 
-- PARENT
MERGE INTO citys ct
USING (
    SELECT DISTINCT
        o.CITY_ID AS CITY_ID,
        o.CITY AS CITY
    FROM customers_old o
) TBL
ON (ct.CITY_ID = TBL.CITY_ID)
 WHEN MATCHED THEN
    UPDATE SET
        ct.CITY_NAME = TBL.CITY,
        ct.CREATE_DATE = SYSDATE,
        ct.MODE_INSERT = 'UPDATE'
    WHEN NOT MATCHED THEN
        INSERT (ct.CITY_ID, ct.CITY_NAME, ct.COUNTRY, ct.CREATE_DATE, ct.MODE_INSERT)
        VALUES (TBL.CITY_ID, TBL.CITY, '', SYSDATE, 'INSERT');
-- CHild
MERGE INTO customers_new_2 n2
    USING (
        SELECT
            o.CUSTOMER_OLD_ID AS CUSTOMER_OLD_ID,
            o.CUSTOMER_OLD_NAME AS CUSTOMER_OLD_NAME,
            o.CITY_ID AS CITY_ID
        FROM customers_old o    
    ) TBL
    ON (
        TBL.CUSTOMER_OLD_ID = n2.CUSTOMER_NEW_ID AND
        TBL.CITY_ID = n2.CITY_ID
    )
    WHEN MATCHED THEN
        UPDATE SET 
            n2.CUSTOMER_NEW_NAME = TBL.CUSTOMER_OLD_NAME,
            n2.UPDATE_DATE = SYSDATE,
            n2.MODE_INSERT = 'UPDATE'
    WHEN NOT MATCHED THEN
        INSERT (n2.CUSTOMER_NEW_ID, n2.CUSTOMER_NEW_NAME, n2.CITY_ID, n2.UPDATE_DATE, n2.MODE_INSERT)
        VALUES (TBL.CUSTOMER_OLD_ID, TBL.CUSTOMER_OLD_NAME, TBL.CITY_ID, SYSDATE, 'INSERT');

--5-2) Tr??ng h?p CÓ ?ánh s? sequence, KHÔNG phát sinh update
DECLARE
    CURSOR dataTable IS SELECT * FROM customers_old;
BEGIN
    FOR idx IN dataTable LOOP
        /* SQL parent */
    END LOOP;
END;