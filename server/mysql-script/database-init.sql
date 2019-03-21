drop if exists database caritas_main;
create database caritas_main;
use caritas_main;

drop if exists table personnel;

create table personnel
(id varchar(64) primary key,p_name varchar(128), p_role int not null, Extra varchar(1024));

create table master_record
(id varchar(64) primary key,location varchar(128),token varchar(128));

create table record_form
(id varchar(64) primary key,parent_token varchar(128),student_id varchar(64),data_json varchar(1024)); /*parent_token:the id at master_record*/

create table staff_location
(id varchar(64) primary key, Location varchar(128));

create table id_list/*to ensure unique id*/
(id varchar(64) primary key, used_id varchar(64), in_table varchar(128));

/*
data_json
store form data in json;
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
