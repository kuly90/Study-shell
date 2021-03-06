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
    
-- 2) n :1Tr??ng h?p c?c Table chuy?n giao kh?ng c? quan h? v?i nhau?
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
        
-- 3)  n :1Tr??ng h?p get item c?a Table ??ch chuy?n ??i t? nhi?u Table chuy?n giao?
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
        
-- 4) 1:n  Tr??ng h?p chia ra th?nh nhi?u Table ??ch chuy?n ??i r?i th?c hi?n chuy?n ??i
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

--5) 1:n Tr??ng h?p chuy?n ??i theo set ??i v?i TBL c? quan h? parent-child
-- 5-1) Tr??ng h?p ko c? ??nh s? sequence 
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

--5-2) Tr??ng h?p C? ??nh s? sequence, KH?NG ph?t sinh update
DECLARE
    CURSOR lstCustomer IS
        SELECT DISTINCT o.CITY_ID FROM customers_old o;
BEGIN
    For cus IN lstCustomer Loop
        /*SQL insert parent */
        INSERT INTO city_seq
            SELECT DISTINCT
                o.CITY_ID, o.CITY, 'A', SYSDATE, 'INSERT'
            FROM customers_old o
            WHERE o.CITY_ID = cus.CITY_ID
        ;
        /* SQL insert child */
        INSERT INTO customers_new_seq
            SELECT
                o.CUSTOMER_OLD_ID, o.CUSTOMER_OLD_NAME, o.CITY_ID, SYSDATE, 'INSERT'
            FROM customers_old o
            WHERE o.CITY_ID = cus.CITY_ID
        ;   
    END LOOP;
END;
---------------------------------------------
DECLARE
    CURSOR lstCustomer IS
        SELECT DISTINCT o.CITY_ID FROM customers_old o;
    CITYID_ALL CHAR(3);
BEGIN
    For cus IN lstCustomer Loop
    CITYID_ALL := TO_CHAR(CUST_SEQ.nextval);
        /*SQL insert parent */
        INSERT INTO city_seq
            SELECT DISTINCT
                CITYID_ALL, o.CITY, 'A', SYSDATE, 'INSERT'
            FROM customers_old o
            WHERE o.CITY_ID = cus.CITY_ID
        ;
        /* SQL insert child */
        INSERT INTO customers_new_seq
            SELECT
                o.CUSTOMER_OLD_ID, o.CUSTOMER_OLD_NAME, CITYID_ALL, SYSDATE, 'INSERT'
            FROM customers_old o
            WHERE o.CITY_ID = cus.CITY_ID
        ;   
    END LOOP;
END;

select * from customers_old;
select * from city_seq;
select * from customers_new_seq;

delete  from customers_new_seq;
delete  from city_seq;


-- 5-3 Tr??ng h?p C? ??nh s? sequence, C? update
SET SERVEROUTPUT ON;
DECLARE
    CURSOR lstCustomer IS
        SELECT DISTINCT o.CITY_ID FROM customers_old o;
    CITYID CHAR(3);
BEGIN
    For cus IN lstCustomer Loop
        /*SQL insert parent */
        MERGE INTO city_seq ct
        USING
            (
                SELECT DISTINCT o.CITY_ID AS CITY_ID, o.CITY AS CITY_NAME
                FROM customers_old o
                WHERE o.CITY_ID = cus.CITY_ID    
            ) TBL
        ON (ct.CITY_ID = TBL.CITY_ID)
        WHEN MATCHED THEN
            UPDATE SET 
                ct.CITY_NAME = TBL.CITY_NAME,
                ct.CREATE_DATE = SYSDATE,
                MODE_INSERT = 'UPDATE'
        WHEN NOT MATCHED THEN
            INSERT (ct.CITY_ID, ct.CITY_NAME, ct.COUNTRY, ct.CREATE_DATE, MODE_INSERT)
            VALUES (TBL.CITY_ID, TBL.CITY_NAME, 'VIETNAM', SYSDATE, 'INSERT')
        ;
        /*Get ID ?? insert ? SQL c?a parent */
        SELECT ct.CITY_ID INTO CITYID
        FROM city_seq ct
        WHERE ct.CITY_ID = cus.CITY_ID
        ; 
        /* SQL insert child */
        MERGE INTO customers_new_seq nsq
        USING 
            (
                SELECT
                    o.CUSTOMER_OLD_ID AS CUSTOMER_OLD_ID,
                    o.CUSTOMER_OLD_NAME AS CUSTOMER_OLD_NAME,
                    o.CITY_ID AS CITY_ID
                FROM customers_old o
                WHERE o.CITY_ID = cus.CITY_ID 
            ) TBL
        ON (nsq.CITY_ID = TBL.CITY_ID AND
            nsq.CUSTOMER_NEW_ID = TBL.CUSTOMER_OLD_ID)
        WHEN MATCHED THEN
            UPDATE SET
                nsq.CUSTOMER_NEW_NAME = TBL.CUSTOMER_OLD_NAME,
                nsq.UPDATE_DATE = SYSDATE,
                nsq.MODE_INSERT = 'UPDATE'
        WHEN NOT MATCHED THEN
            INSERT (nsq.CUSTOMER_NEW_ID, nsq.CUSTOMER_NEW_NAME, nsq.CITY_ID, nsq.UPDATE_DATE, nsq.MODE_INSERT)
            VALUES (TBL.CUSTOMER_OLD_ID, TBL.CUSTOMER_OLD_NAME, TBL.CITY_ID, SYSDATE, 'INSERT')
            ;
    END LOOP;
END;




-- 5-4)
DECLARE
    CURSOR lstCustomer IS
        SELECT DISTINCT
            o.CITY_ID AS CITY_ID,
            ct.CITY_ID AS IDPR
        FROM customers_old o
        LEFT OUTER JOIN city_seq ct
        ON o.CITY_ID = ct.CITY_ID
        ORDER BY IDPR;
BEGIN
    For cus IN lstCustomer Loop
    /*N?u ko c? ID th? ??nh s? t? sequence*/
    IF ( cus.IDPR is null ) THEN
        cus.IDPR := TO_CHAR(CUST_SEQ.nextval);
    END IF;
        /*SQL insert parent */
        MERGE INTO city_seq ct
        USING 
            (
                SELECT DISTINCT
                    o.CITY_ID AS CITY_ID,
                    o.CITY AS CITY_NAME
                FROM customers_old o
                WHERE o.CITY_ID = cus.CITY_ID
            ) TBL
        ON (ct.CITY_ID = TBL.CITY_ID)
        WHEN MATCHED THEN
            UPDATE SET
                ct.CITY_NAME = TBL.CITY_NAME,
                ct.COUNTRY = 'CITY',
                ct.CREATE_DATE = SYSDATE,
                ct.MODE_INSERT = 'UPDATE'
        WHEN NOT MATCHED THEN
        INSERT (ct.CITY_ID, ct.CITY_NAME, ct.COUNTRY, ct.CREATE_DATE, ct.MODE_INSERT)
        VALUES (cus.IDPR, TBL.CITY_NAME, 'CITY', SYSDATE, 'INSERT')
        ;
        /* SQL insert child */
        MERGE INTO customers_new_seq nsq
            USING 
            (
                SELECT
                    o.CITY_ID AS CITY_ID,
                    o.CUSTOMER_OLD_ID AS CUSTOMER_OLD_ID,
                    o.CUSTOMER_OLD_NAME AS CUSTOMER_OLD_NAME
                FROM customers_old o
                WHERE o.CITY_ID = cus.CITY_ID
            ) TBL
        ON (nsq.CITY_ID = TBL.CITY_ID AND
            nsq.CUSTOMER_NEW_ID = TBL.CUSTOMER_OLD_ID)
        WHEN MATCHED THEN
            UPDATE SET
                nsq.CUSTOMER_NEW_NAME = TBL.CUSTOMER_OLD_NAME,
                nsq.UPDATE_DATE = SYSDATE,
                nsq.MODE_INSERT = 'UPDATE'
        WHEN NOT MATCHED THEN
        INSERT (nsq.CUSTOMER_NEW_ID, nsq.CUSTOMER_NEW_NAME, nsq.CITY_ID, nsq.UPDATE_DATE, nsq.MODE_INSERT)
        VALUES (TBL.CUSTOMER_OLD_ID, TBL.CUSTOMER_OLD_NAME, cus.IDPR, SYSDATE, 'INSERT')
        ;
    END LOOP;
END;

INSERT INTO city_seq VALUES ('NEW', 'A','','','');
INSERT INTO customers_new_seq VALUES ('OLD005','A','NEW','','');

select * from customers_old;
select * from city_seq;
select * from customers_new_seq;

delete  from customers_new_seq;
delete  from city_seq;



