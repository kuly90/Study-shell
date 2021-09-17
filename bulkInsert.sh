#!/bin/bash
current_date=$(date +%Y-%m-%d)
DB_UserName="ABC"
DB_Password="123456"
DB_Hostname="localhost"
DB_Port="1521"
DB_SID="ORCL"
DB_Connect="sqlplus -S ${DB_UserName}/${DB_Password}@//${DB_Hostname}:${DB_Port}/${DB_SID}"
DB_SQL_COUNT_QUERY="select count(*) from customers;"
DB_SQL_DATA_QUERY="select customer_name from customers ORDER BY customer_name;"

# get count data from ABC.customers
count=`${DB_Connect} <<EOF
set feedback off
set heading off
set pagesize 0
set tab off
${DB_SQL_COUNT_QUERY}
exit
EOF`

# get data from ABC.customers
dataResult=`${DB_Connect} <<EOM
set feedback off
set heading off
set pagesize 0
set tab off
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
        INSERT INTO ABCDEF.orders VALUES (orderId(idx), orderName(idx), 'CITY');
    END LOOP;
END;
EOM`

# output log when insert data
function bulk_insert_data() {
    ${DB_Connect} @ <<EOF >bulk_insert_data_$current_date.log
    set lines 12345 pages 12345;
    col username for a30;
    col open_mode for a30;

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
            INSERT INTO ABCDEF.orders VALUES (orderId(idx), orderName(idx), 'CITY');
        END LOOP;
    END;

EXIT
EOF
}

#check data
echo $count
if [ $count == 0 ]; then
    echo "Database is being re-imported"
else
    echo "Database is OK"
    $dataResult
fi
