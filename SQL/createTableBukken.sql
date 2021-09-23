CREATE TABLE "ABC"."BUKKEN" 
   ("tateya_id" NUMBER(8,0) NOT NULL, 
	"heya_id"  NUMBER(4,0) NOT NULL PRIMARY KEY, 
	"bukken_shbt_kbn" CHAR(1), 
	"aps_karidome_moshikomi_flg" CHAR(1),
    "aps_moshikomi_ng_flg" CHAR(1),
    "karidome_flg" CHAR(1),
    "karidome_ten_cd" CHAR(1),
    "kushitsu_chk_ymdhms" DATE,
    "kushitsu_chk_ten_cd"  VARCHAR(4),
    "kushitsu_chk_user_id" NUMBER(6,0),
    "nyukyo_kano_date_kbn" CHAR(1),
    "nyukyo_kano_ymd" DATE,
    "nyukyo_kano_ym" VARCHAR(6),
    "nyukyo_kano_jun_kbn" CHAR(1),
    "kushitsu_jokyo_kbn" CHAR(1) NOT NULL,
    "cre_tmstmp" TIMESTAMP,
    "cre_user_cd" VARCHAR(20),
    "cre_ten_cd" VARCHAR(4),
    "cre_kigyo_cd" VARCHAR(4),
    "cre_kigyo_grp_cd" VARCHAR(4),
    "upd_tmstmp" TIMESTAMP,
    "upd_user_cd" VARCHAR(20),
    "upd_ten_cd" VARCHAR(4),
    "del_flg" CHAR(1),
    "ver_no" NUMBER(10,0)
   );