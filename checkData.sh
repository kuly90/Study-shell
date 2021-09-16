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

# output log when no data found
function no_data() {
    cat <<- EOF >no_data_$current_date.log
    No Data Found For SQL_QUERY:
    ${DB_SQL_COUNT_QUERY}
    
EOF
}

# output log when find data
function select_data() {
    ${DB_Connect} <<EOF >result_data_$current_date.log
    set lines 12345 pages 12345;
    col username for a30;
    col open_mode for a30;
    ${DB_SQL_DATA_QUERY}

EXIT
EOF
}

# output log when insert data
function insert_data() {
    ${DB_Connect} <<EOF >insert_data_$current_date-$1.log
    set lines 12345 pages 12345;
    col username for a30;
    col open_mode for a30;
    INSERT INTO orders VALUES($1, '$2', 'AAA');

EXIT
EOF
}

#check data
echo $count
if [ $count == 0 ]; then
    echo "Database is being re-imported"
    no_data
else
    list=$(expr $count - 1)
    echo "Database is OK"
    select_data
    i=1
    for value in ${dataResult}
    do
        id=$i
        customer_name[$i]=${value}
        customer_name=${customer_name[$i]}
        insert_data $id $customer_name
        let i+=1
        echo $customer_name
    done
fi

