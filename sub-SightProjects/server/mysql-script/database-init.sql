drop database if exists caritas_main;
create database caritas_main;
use caritas_main;

drop table if exists personnel;
drop table if exists master_record;
drop table if exists record_child;
drop table if exists staff_location;
drop table if exists record_form;
drop table if exists tmp_list;
create table personnel
(id varchar(64) primary key,p_name varchar(128), p_role int not null, Extra varchar(1024));

create table master_record
(id varchar(64) primary key,t_location varchar(128),token varchar(128));

create table record_form
(id varchar(64) primary key,parent_token varchar(128),student_id varchar(64),data_json varchar(1024)); /*parent_token:the id at master_record*/

create table staff_location
(id varchar(64) primary key,ltime datetime, Location varchar(128));

create table pop_list
(sid varchar(128),Location varchar(128),unitok varchar(128), type int default 1);

create table tmp_list
(token varchar(128));
/*
type 0: pop up
type 1: pop out
*/

create table record_child
(id varchar(64) primary key, parent_token varchar(128),
    student_id varchar(64), record_time datetime default now(), child_status int);

/*
child_status :
0: get in
1: get out
2: not sure

if submit form  change [2] to [0] and insert one row of [1]
*/

create table id_list/*to ensure unique id*/
(id varchar(128) primary key);
/*
does not need anything else other then id
use below to generate unique id
*/
/*
  set @id = md5(TO_BASE64(now()+rand()));
  while (select count(*) from id_list where id_list.id = @id) > 0 do
    set @id = md5(TO_BASE64(now()+rand()));
  end while;
*/

/*
data_json
store form data in json;
*/
insert into personnel values("000",'root',0,null);
insert into personnel values('001','student a',1,null);
insert into personnel values('002','student b',1,null);
insert into personnel values('003','student c',1,null);
insert into personnel values("01-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00",'root',0,null);
insert into personnel values('00-01-00-00-00-00-00-00-00-00-00-00-00-00-00-00','student a',1,null);
insert into personnel values('00-02-00-00-00-00-00-00-00-00-00-00-00-00-00-00','student b',1,null);
insert into personnel values('00-03-00-00-00-00-00-00-00-00-00-00-00-00-00-00','student c',1,null);
