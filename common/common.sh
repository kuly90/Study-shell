#!/bin/bash

current_date=$(date +%Y-%m-%d)
DB_UserName="ABC"
DB_Password="123456"
DB_Hostname="localhost"
DB_Port="1521"
DB_SID="ORCL"
DB_Connect="sqlplus -S ${DB_UserName}/${DB_Password}@//${DB_Hostname}:${DB_Port}/${DB_SID}"
