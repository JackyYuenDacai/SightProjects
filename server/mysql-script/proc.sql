DELIMITER ';'
use caritas_main;

drop function if exists generate_unique_id;

drop procedure if exists RoutineCheck;
drop procedure if exists tagScanned;
drop procedure if exists submitForm;
drop procedure if exists getPopList;
drop procedure if exists getStaffList;
drop procedure if exists getUserRecord;
drop procedure if exists getTagsViaLocation;
drop procedure if exists getUserIconPath;
drop procedure if exists setUserIconPath;

drop event if exists Event_Second;

set global log_bin_trust_function_creators=TRUE;
SET GLOBAL sql_mode = 'NO_ENGINE_SUBSTITUTION';
SET SESSION sql_mode = 'NO_ENGINE_SUBSTITUTION';

source ./proc-input.sql
source ./proc-output.sql
source ./proc-routine.sql
source ./func-utils.sql







DELIMITER ';';
