#!/bin/bash

source common/common.sh
SQL_INSERT_FILE="SQL\inser_by_csv.sql"
file=file/data.csv
exec < ${file}
read header
IFS=', ' read -ra lstHeader <<< "$header";

for ((i=0; i<${#lstHeader[*]}; i++))
    do
        if [ "kushitsu_chk_ymdhms" == ${lstHeader[$i]} ]; then
            numberOfTime=$i;
            break
        fi
    done
echo ${numberOfTime}

while read line
do
    IFS=', ' read -ra array <<< "$line";
    tateya_id=\'${array[0]}\'
    if [ -z "$tateya_id" ]; then
        echo "NULL" 
    else
        echo "Not NULL";
    fi
    heya_id=\'${array[1]}\'
    bukken_shbt_kbn=\'${array[2]}\'
    aps_karidome_moshikomi_flg=\'${array[3]}\'
    aps_moshikomi_ng_flg=\'${array[4]}\'
    karidome_flg=\'${array[5]}\'
    karidome_ten_cd=\'${array[6]}\'
    kushitsu_chk_ymdhms=${array[7]}
    kushitsu_chk_ten_cd=\'${array[8]}\'
    kushitsu_chk_user_id=\'${array[9]}\'
    kushitnyukyo_kano_date_kbn=\'${array[10]}\'
    nyukyo_kano_ymd=\'${array[11]}\'
    nyukyo_kano_ym=\'${array[12]}\'
    nyukyo_kano_jun_kbn=\'${array[13]}\'
    kushitsu_jokyo_kbn=\'${array[14]}\'
    cre_tmstmp=\'${array[15]}\'
    cre_user_cd=\'${array[16]}\'
    cre_ten_cd=\'${array[17]}\'
    cre_kigyo_cd=\'${array[18]}\'
    cre_kigyo_grp_cd=\'${array[19]}\'
    upd_tmstmp=\'${array[20]}\'
    upd_user_cd=\'${array[21]}\'
    upd_ten_cd=\'${array[22]}\'
    del_flg=\'${array[23]}\'
    ver_no=\'${array[24]}\'

    kushitsu_chk_ymdhms_date="${kushitsu_chk_ymdhms:0:4}"
    kushitsu_chk_ymdhms_date="${kushitsu_chk_ymdhms_date}-"
    kushitsu_chk_ymdhms_date="${kushitsu_chk_ymdhms_date}${kushitsu_chk_ymdhms:4:2}"
    kushitsu_chk_ymdhms_date="${kushitsu_chk_ymdhms_date}-"
    kushitsu_chk_ymdhms_date="${kushitsu_chk_ymdhms_date}${kushitsu_chk_ymdhms:6:2}"
    kushitsu_chk_ymdhms_date_insert=\'$kushitsu_chk_ymdhms_date\'
    
   ${DB_Connect} <<EOF >insert_by_file_csv_$current_date.log

    @${SQL_INSERT_FILE} ${tateya_id} \
                        ${heya_id} \
                        "$bukken_shbt_kbn" \
                        "$aps_karidome_moshikomi_flg" \
                        "$aps_moshikomi_ng_flg" \
                        "$karidome_flg" \
                        "$karidome_ten_cd" \
                        "$kushitsu_chk_ymdhms_date_insert" \
                        "$kushitsu_chk_ten_cd" \
                        "$kushitsu_chk_user_id" \
                        "$kushitnyukyo_kano_date_kbn" \
                        "$nyukyo_kano_ymd" \
                        "$nyukyo_kano_ym" \
                        "$nyukyo_kano_jun_kbn" \
                        "$kushitsu_jokyo_kbn" \
                        "$cre_tmstmp" \
                        "$cre_user_cd" \
                        "$cre_ten_cd" \
                        "$cre_kigyo_cd" \
                        "$cre_kigyo_grp_cd" \
                        "$upd_tmstmp"\
                        "$upd_user_cd" \
                        "$upd_ten_cd" \
                        "$del_flg" \
                        $ver_no
EXIT
EOF

done 