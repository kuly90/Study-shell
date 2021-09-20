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
SQL_FILE="SQL\file_insert.sql"

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
function insert_by_file() {
    ${DB_Connect} <<EOF >insert_by_file_$current_date.log
    set lines 12345 pages 12345;
    col username for a30;
    col open_mode for a30;
    @${SQL_FILE} "$1" "$2" "$3"

EXIT
EOF
}

#check data
# list customer name
lstCusName=()
# list City
listCity=()

#check data
echo $count
if [ $count == 0 ]; then
    echo "Database is being re-imported"
else
    i=0
    for value in ${dataResult}
    do
        if [ `expr $i % 3` == 0 ]; then
            customer_name[$i]=${value}
            customer_name=${customer_name[$i]}
            # add customer name 
            lstCusName+=($customer_name)
        elif [ `expr $i % 3` == 1 ]; then
            city[$i]=${value}
            city=${city[$i]}
            # add city
            listCity+=($city)
        fi
        let i+=1
    done
fi

# check size customer
if [ ${#listCity[*]} > 0 ]; then
    # loop customer to insert
    for ((i=0; i<${#listCity[*]}; i++))
    do
        cusName=\'${lstCusName[$i]}\'
        city=\'${listCity[$i]}\'
        id=`expr $i + 1`
        echo ${cusName}
        insert_by_file $id $cusName $city
    done
fi
