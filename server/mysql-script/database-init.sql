drop if exists database caritas_main;
create database caritas_main;
use caritas_main;

drop if exists table personnel;

create table personnel
(id varchar(64) primary key,Name varchar(128), Role int not null, Extra varchar(1024));

create table bathroom_record
(id varchar(64) primary key,Location varchar(128),token varchar(128));

create table record_child
(id varchar(64) primary key, parent_token varchar(128), 
    pp_id varchar(64), time datetime default now(), status int);
/*
status :
0: get in
1: get out
2: not sure

if submit form  change [2] to [0] and insert one row of [1]
*/