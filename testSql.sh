#!/bin/bash
current_date=$(date +%Y-%m-%d)
DB_UserName="ABC"
DB_Password="123456"
DB_Hostname="localhost"
DB_Port="1521"
DB_SID="ORCL"
DB_Connect="sqlplus -S ${DB_UserName}/${DB_Password}@//${DB_Hostname}:${DB_Port}/${DB_SID}"

${DB_Connect} <<EOF >show_data_$current_date.log
set lines 12345 pages 12345;

col username for a30;
col open_mode for a30;

select * from customers;

--insert into customers values ('3', 'cc', 'cc');
EXIT
EOF

# get data from ABC.customers
list=`${DB_Connect} <<EOF
set feedback off
set serveroutput on
set heading off
set pagesize 0
set tab off
select customer_name from customers FETCH NEXT 5 ROWS ONLY
/
exit
EOF`

# Insert data from ABC.customers to ABCDEF.Orders
function insert_datas() {
    ${DB_Connect} <<EOF >insert_data_$current_date_$1.log
    set lines 12345 pages 12345;

    col username for a30;
    col open_mode for a30;
    insert into ABCDEF.ORDERS VALUES ('$1', '$2', 'a');
    EXIT
EOF
}

i=0
for value in ${list}
do
    customer_name[$i]=${value}
    id=$i
    customer_name=${customer_name[$i]}
    echo "customer_name[$i] = ${customer_name[$i]}"
    insert_datas $id $customer_name
    let i+=1
done
