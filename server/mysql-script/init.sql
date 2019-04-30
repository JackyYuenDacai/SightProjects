drop database if exists caritas_main;
create database caritas_main;
use caritas_main;

drop table if exists personnel;
drop table if exists master_record;
drop table if exists record_child;
drop table if exists staff_location;
drop table if exists record_form;
drop table if exists tmp_list;
drop table if exists tags_location;

create table personnel
(id varchar(64) primary key,p_name varchar(128), p_role int not null, Extra varchar(1024));

create table master_record
(id varchar(64) primary key,t_location varchar(128),token varchar(128));

create table user_iconpath
(id varchar(64) primary key,icon_path varchar(256));

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

create table ret_query_list
(token varchar(64) primary key, name varchar(64),student_id varchar(64),location varchar(64),time_in datetime, time_interval time, data_json varchar(1024));

create table id_list/*STORE UNIQUE ID*/
(id varchar(128) primary key);

create table tags_location/*GIVES RECOMMAND LIST OF TAGS FOR EACH LOCATION*/
(id varchar(64) , ltime datetime, location varchar(128) , IsRegistered boolean);

create table tags_linkage
(pid varchar(64), tagId varchar(128));

source ./init-sample-data.sql;
