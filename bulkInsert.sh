#!/bin/bash
current_date=$(date +%Y-%m-%d)
DB_UserName="ABC"
DB_Password="123456"
DB_Hostname="localhost"
DB_Port="1521"
DB_SID="ORCL"
DB_Connect="sqlplus -S ${DB_UserName}/${DB_Password}@//${DB_Hostname}:${DB_Port}/${DB_SID}"
DB_SQL_COUNT_QUERY="select count(*) from customers;"
DB_SQL_DATA_QUERY="select customer_name, city from customers ORDER BY customer_id;"
SQL_FILE="SQL/bulkInsert.sql"
# get count data from ABC.customers
count=`${DB_Connect} <<EOF
set feedback off
set heading off
set pagesize 0
set tab off
${DB_SQL_COUNT_QUERY}
exit
EOF`

# output log when insert data
function bulk_insert_by_file() {
    ${DB_Connect} <<EOF >bulk_insert_by_file_$current_date.log
    Set timing on
    set lines 12345 pages 12345;
    col username for a30;
    col open_mode for a30;
    execute ${SQL_FILE};
    commit;

EXIT
EOF
}

#check data
echo $count
if [ $count == 0 ]; then
    echo "Database is being re-imported"
else
    bulk_insert_by_file
fi
