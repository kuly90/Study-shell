insert into customers_new VALUES ('NEW001', 'A', 'A', '');
insert into customers_new VALUES ('OLD002', 'B', 'B', '');
insert into customers_new VALUES ('NEW003', 'C', 'C', '');
insert into customers_new VALUES ('OLD004', 'D', 'D', '');
insert into customers_new VALUES ('NEW005', 'E', 'E', '');

select * from customers_new ORDER BY customer_new_id;
delete from customers_new;

-- ??:?
MERGE INTO customers_new n
    USING customers_old o
    ON (n.CUSTOMER_NEW_ID = o.CUSTOMER_OLD_ID)
    WHEN MATCHED THEN
        UPDATE SET 
            n.CUSTOMER_NEW_NAME = o.CUSTOMER_OLD_NAME,
            n.CITY = o.CITY,
            n.UPDATE_DATE = SYSDATE
    WHEN NOT MATCHED THEN
        INSERT (n.CUSTOMER_NEW_ID, n.CUSTOMER_NEW_NAME, n.CITY, n.UPDATE_DATE)
        VALUES (o.CUSTOMER_OLD_ID, o.CUSTOMER_OLD_NAME, o.CITY, SYSDATE);
    
-- ?n :??Tr??ng h?p các Table chuy?n giao không có quan h? v?i nhau?
MERGE INTO customers_new n
    USING customers_old o
    ON (n.CUSTOMER_NEW_ID = o.CUSTOMER_OLD_ID)
    WHEN MATCHED THEN
        UPDATE SET 
            n.CUSTOMER_NEW_NAME = o.CUSTOMER_OLD_NAME,
            n.CITY = o.CITY,
            n.UPDATE_DATE = SYSDATE
    WHEN NOT MATCHED THEN
        INSERT (n.CUSTOMER_NEW_ID, n.CUSTOMER_NEW_NAME, n.CITY, n.UPDATE_DATE)
        VALUES (o.CUSTOMER_OLD_ID, o.CUSTOMER_OLD_NAME, o.CITY, SYSDATE);

MERGE INTO customers_new n
    USING customers_old_1 o1
    ON (n.CUSTOMER_NEW_ID = o1.CUSTOMER_OLD_ID)
    WHEN MATCHED THEN
        UPDATE SET 
            n.CUSTOMER_NEW_NAME = o1.CUSTOMER_OLD_NAME,
            n.CITY = o1.CITY,
            n.UPDATE_DATE = SYSDATE
    WHEN NOT MATCHED THEN
        INSERT (n.CUSTOMER_NEW_ID, n.CUSTOMER_NEW_NAME, n.CITY, n.UPDATE_DATE)
        VALUES (o1.CUSTOMER_OLD_ID, o1.CUSTOMER_OLD_NAME, o1.CITY, SYSDATE);
        
-- ?  n :??Tr??ng h?p get item c?a Table ?ích chuy?n ??i t? nhi?u Table chuy?n giao?
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
            n.UPDATE_DATE = SYSDATE
    WHEN NOT MATCHED THEN
        INSERT (n.CUSTOMER_NEW_ID, n.CUSTOMER_NEW_NAME, n.CITY, n.UPDATE_DATE)
        VALUES (TBL.CUSTOMER_OLD_ID, TBL.CUSTOMER_OLD_NAME, TBL.CITY, SYSDATE);