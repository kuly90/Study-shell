SET SERVEROUTPUT ON;
DECLARE
    TYPE order_id IS TABLE OF NUMBER(10,0);
    TYPE order_name IS TABLE OF VARCHAR2(50);
    orderId order_id;
    orderName order_name;
BEGIN
    SELECT customer_id, customer_name BULK COLLECT INTO orderId, orderName
    FROM ABC.customers;
    FOR idx IN 1..orderId.COUNT
    LOOP
        INSERT INTO ABCDEF.orders VALUES (orderId(idx), orderName(idx), 'city');
    END LOOP;
END;