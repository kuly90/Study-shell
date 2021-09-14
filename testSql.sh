#!/bin/bash
current_date=$(date +%Y-%m-%d)
DB_UserName="ABC"
DB_Password="123456"
DB_Hostname="localhost"
DB_Port="1521"
DB_SID="ORCL"

sqlplus -S ${DB_UserName}/${DB_Password}@//${DB_Hostname}:${DB_Port}/${DB_SID} <<EOF >database_status_$current_date.log
set lines 12345 pages 12345;

col username for a30;
col open_mode for a30;

select * from customers;

--insert into customers values ('3', 'cc', 'cc');
EXIT
EOF
