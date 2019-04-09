DELIMITER ';'
drop database if exists caritas_db;

create database caritas_db;
use caritas_db;
drop procedure if exists tagScanned;
drop table if exists tmp_record;
create table tmp_record(id varchar(64) primary key, rtime datetime, userdata varchar(64),location varchar(64));


DELIMITER '/$'

create procedure caritas_db.tagScanned(userdata varchar(64),location varchar(64)) begin
	select md5(TO_BASE64(now()+rand())) into @fkey;
	insert into tmp_record values(md5(TO_BASE64(now()+rand())), now(), userdata , location);
end; /$
/$

DELIMITER ';'

