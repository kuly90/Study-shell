SET SERVEROUTPUT ON;
DECLARE
    TYPE order_id IS TABLE OF NUMBER(10,0);
    TYPE order_name IS TABLE OF VARCHAR2(50);
    TYPE cities IS TABLE OF VARCHAR2(50);
    orderId order_id;
    orderName order_name;
    city cities;
BEGIN
    SELECT customer_id, customer_name, city BULK COLLECT INTO orderId, orderName, city
    FROM ABC.customers;
    FOR idx IN 1..orderId.COUNT
    LOOP
        INSERT ALL
            INTO ABCDEF.orders VALUES (orderId(idx), orderName(idx), city(idx))
            INTO ABCDEF.shipers VALUES (orderId(idx), orderName(idx), city(idx))
        SELECT * FROM dual;
    END LOOP;
END;