select * from customers_new ORDER BY customer_new_id;
select * from customers_new_1 ORDER BY customer_new_id;
select * from citys;

delete from customers_new;
delete from customers_new_1;


insert into customers_new VALUES ('NEW001', 'New', 'New', '', '');
insert into customers_new VALUES ('OLD002', 'New', 'New', '', '');
insert into customers_new VALUES ('NEW003', 'New', 'New', '', '');
insert into customers_new VALUES ('OLD004', 'New', 'New', '', '');
insert into customers_new VALUES ('NEW005', 'New', 'New', '', '');

insert into customers_new_1 VALUES ('NEW001', 'New 1', 'New 1', '', '');
insert into customers_new_1 VALUES ('OLD002', 'New 1', 'New 1', '', '');
insert into customers_new_1 VALUES ('NEW003', 'New 1', 'New 1', '', '');
insert into customers_new_1 VALUES ('OLD004', 'New 1', 'New 1', '', '');
insert into customers_new_1 VALUES ('NEW005', 'New 1', 'New 1', '', '');

insert into customers_new_2 VALUES ('NEW001', 'New 1', 'DAN', '', '');
insert into customers_new_2 VALUES ('OLD002', 'New 1', 'DAN', '', '');
insert into customers_new_2 VALUES ('NEW003', 'New 1', 'TOK', '', '');
insert into customers_new_2 VALUES ('OLD004', 'New 1', 'TOK', '', '');
insert into customers_new_2 VALUES ('NEW005', 'New 1', 'NEW', '', '');
delete customers_new_2;
CREATE SEQUENCE supplier_seq
  MINVALUE 1
  START WITH 1
  INCREMENT BY 1
  CACHE 20;
