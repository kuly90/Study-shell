#!/bin/bash
source common/common.sh
source SQL/bulkInsert.sh

DB_SQL_COUNT_QUERY="select count(*) from customers;"
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
    SET SERVEROUTPUT ON;
    execute ${SQL}
    commit;

EXIT
EOF
}

#check data
echo $count
if [ $count == 0 ]; then
    echo "Database is being re-imported"
else
    echo $SQL
    bulk_insert_by_file
fi
