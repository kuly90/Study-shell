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
dataResult=`${DB_Connect} <<EOF
set feedback off
set heading off
set pagesize 0
set tab off
${DB_SQL_DATA_QUERY}
exit
EOF`

# output log when insert data
function insert_first_data() {
    ${DB_Connect} <<EOF >insert_first_data_$current_date.log
    set lines 12345 pages 12345;
    col username for a30;
    col open_mode for a30;
    INSERT FIRST
        WHEN $1 <= 2 THEN
            INTO ABCDEF.shipers VALUES ($1, '$2', 'AAA')
        ELSE
            INTO ABCDEF.orders VALUES ($1, '$2', 'AAA')
    SELECT * FROM dual;

EXIT
EOF
}

#check data
echo $count
if [ $count == 0 ]; then
    echo "Database is being re-imported"
else
    echo "Database is OK"
    i=1
    for value in ${dataResult}
    do
        id=$i
        customer_name[$i]=${value}
        customer_name=${customer_name[$i]}
        echo "customer_name[$i] = ${customer_name[$i]}"
        insert_first_data $id $customer_name
        let i+=1
        echo $customer_name
    done
fi
