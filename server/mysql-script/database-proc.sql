DELIMITER ';'
use caritas_main;
drop function if exists generate_unique_id;
drop procedure if exists RoutineCheck;
drop procedure if exists tagScanned;
drop procedure if exists submitForm;
drop procedure if exists getPopList;
drop procedure if exists getStaffList;

set global log_bin_trust_function_creators=TRUE;

DELIMITER '/$'

create function generate_unique_id()
returns varchar(128)
begin
  set @id = md5(TO_BASE64(now()+rand()));
  while (select count(*) from id_list where id_list.id = @id) > 0 do
    set @id = md5(TO_BASE64(now()+rand()));
    end while;
  return(@id);
end
/$

create procedure submitForm(pid varchar(128), unitok varchar(128), json_form varchar(1024))
begin
  select count(*) from record_child where parent_token = unitok and student_id = pid into @matched_count;
  if @matched_count = 0 then
    select 'ERROR: students record did not exists';
  else
    insert into record_form values(generate_unique_id(),unitok,pid,json_form);
    insert into record_child values(generate_unique_id(),unitok,pid,now(),1);
    select master_record.t_location into @location from master_record where master_record.token = unitok;
    insert into pop_list values(pid,@location,unitok,1);
    select 'SUCCESS: students form submitted!';
  end if;
end
/$

create procedure RoutineCheck()
begin
  truncate table tmp_list;
  select count(distinct record_child.parent_token) from record_child where
    addtime(record_child.record_time,"96:00:00") >= now() and
    addtime(record_child.record_time,"00:00:30") < now()
    into @expired_record_count;
  insert into tmp_list(token) select distinct record_child.parent_token as token  from record_child where
    addtime(record_child.record_time,"96:00:00") >= now() and
    addtime(record_child.record_time,"00:00:30") < now()
    order by record_child.parent_token;
  set @one = 1;
  while @expired_record_count > 0 do
    select * from tmp_list order by token limit 1 into @currentToken;
    set @expired_record_count = @expired_record_count - 1;
    select count(*) into @Iscompleted from record_child where
      record_child.parent_token = @currentToken and
      record_child.child_status = 1;
    if @Iscompleted = 0 then
      /*APPEND POP OUT*/
      insert into pop_list(sid,location,unitok) select distinct record_child.student_id as sid, master_record.t_location as location, master_record.token as unitok
          from record_child inner join master_record on
          record_child.parent_token = master_record.token
          where record_child.parent_token = @currentToken;

      delete from master_record where master_record.token = @currentToken ;
      delete from record_child where record_child.parent_token = @currentToken ;
      delete from tmp_list order by token limit 1;

    end if;
  end while;

end;
/$

create procedure tagScanned(pid varchar(128), location varchar(128))
begin
  /*
  TODO: Add routine clearing of unfinished records
  */
  call RoutineCheck();
  set @in_parent_token = null;
  set @out_parent_token = null;
  set @p_role = null;
  select distinct personnel.p_role from personnel where id = pid into @p_role;
  if @p_role = 0 then
    delete from staff_location where staff_location.id = pid;
    insert into staff_location values(pid,now(),location);
    select 'SUCCESS: updated staff''s location';
  end if;
  if @p_role = 1 then
      select distinct record_child.parent_token into @in_parent_token from record_child where
        record_child.student_id = pid and (select master_record.t_location from master_record where master_record.token = record_child.parent_token) = location and
        addtime(record_child.record_time,"00:00:30") >= now() and
        record_child.child_status = 0
        limit 1;

      select distinct record_child.parent_token from record_child where
        record_child.student_id = pid and (select master_record.t_location from master_record where master_record.token = record_child.parent_token) = location and
        addtime(record_child.record_time,"00:00:30") >= now() and record_child.child_status = 1
        limit 1
        into @out_parent_token;

      if (@in_parent_token IS NOT NULL and @out_parent_token IS NULL) then
        insert into record_child values(generate_unique_id(),@in_parent_token,pid,now(),2);
        select 'SUCCESS: appended one not sure child record';
      else
        if (@in_parent_token is null and @out_parent_token is null) or
        (@in_parent_token is not null and @out_parent_token is not null) then
          /*NO ANY RECORD*/
          set @unitok = generate_unique_id();
          insert into master_record values(generate_unique_id(),location,@unitok);
          insert into record_child values(generate_unique_id(),@unitok,pid,now(),0);
          select 'SUCCESS: appended one master record';
          insert into pop_list values(pid,location,@unitok,0);
        end if;

      end if;
  end if;
  if @p_role = 2 then
    delete from staff_location where staff_location.id = pid;
    insert into staff_location values(pid,now(),location);
    select 'SUCCESS: updated teacher''s location';
  end if;
  if @p_role is null then
    select 'ERROR: personnel unavail';
  end if;
end;
/$

create procedure getPopList(location varchar(128))
begin
  call RoutineCheck();
  select personnel.p_name as name, pop_list.sid as id, pop_list.type as status, pop_list.unitok as unitok from pop_list inner join personnel on pop_list.sid = personnel.id where pop_list.Location = location;
  delete  from pop_list where pop_list.Location = location;
end;
/$

create procedure getStaffList(location varchar(128))
begin
  select staff_location.id as id, personnel.p_name as name from staff_location inner join personnel on staff_location.id = personnel.id order by ltime limit 5;
end;
/$
DELIMITER ';'
