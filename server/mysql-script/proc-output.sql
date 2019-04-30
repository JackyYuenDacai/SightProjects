DELIMITER ';'

/*
MYSQL SCRIPT
PROCEDURE DATA OUTPUT
*/

DELIMITER '/$'

create procedure getPopList(location varchar(128))
begin
  select personnel.p_name as name, pop_list.sid as id, pop_list.type as status, pop_list.unitok as unitok from pop_list inner join personnel on pop_list.sid = personnel.id where pop_list.Location = location;
  delete  from pop_list where pop_list.Location = location;
end;
/$

create procedure getStaffList(location varchar(128))
begin
  select staff_location.id as id, personnel.p_name as name from
    staff_location inner join personnel on
    staff_location.id = personnel.id where
    staff_location.Location = location
    order by ltime desc limit 5;
end;
/$

create procedure getTagsViaLocation(location varchar(128))
begin
  select tags_location.id as token, tags_location.IsRegistered as IsRegistered
  from tags_location
  where tags_location.location = location
  order by ltime desc
  limit 5;
end;
/$

create procedure getUserRecord(pid varchar(128),time_in datetime)
begin
  truncate table tmp_list;
  insert into tmp_list(token)
    select distinct record_form.parent_token as token
    from (master_record inner join record_form
    on master_record.token = record_form.parent_token)
    where record_form.student_id = pid;
  select count(*) from tmp_list into @RecordCount;
  while @RecordCount > 0 do
    select tmp_list.token from tmp_list order by token limit 1 into @CURToken;
    select record_form.student_id from record_form where record_form.parent_token = @CURToken into @SID;
    select max(record_child.record_time) from record_child where record_child.parent_token = @CURToken into @LATEST;
    select min(record_child.record_time) from record_child where record_child.parent_token = @CURToken into @FIRST;
    select record_form.data_json from record_form where record_form.parent_token = @CURToken into @FORM_DATA;
    select master_record.t_location from master_record where master_record.token = @CURToken into @LOCATION;
    select personnel.p_name from personnel where personnel.id = pid into @PNAME;
    if(@FIRST>time_in) then
      insert into ret_query_list values(@CURToken,@PNAME,@SID,@LOCATION,@FIRST,timediff(@LATEST,@FIRST),@FORM_DATA);
    end if;
    set @RecordCount = @RecordCount - 1;
    delete from tmp_list order by token limit 1;
  end while;
  select student_id as id, name,token,location,ret_query_list.time_in,time_interval,data_json from ret_query_list where ret_query_list.student_id = pid;
  delete from ret_query_list where ret_query_list.student_id = pid;
end;
/$

create procedure getUserIconPath(pid varchar(128))
begin
  select user_iconpath.icon_path into @ICPATH from user_iconpath where user_iconpath.id = pid;
  if @ICPATH = null then
    set @ICPATH = "default.jpg";
    select @ICPATH as path;
  else
    select @ICPATH as path;
  end if;
end;
/$


DELIMITER ';';
