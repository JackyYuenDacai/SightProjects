DELIMITER ';'

/*
MYSQL SCRIPT
PROCEDURE INPUT DATA
*/

DELIMITER '/$'

create procedure setUserIconPath(pid varchar(128), icon_path varchar(256))
begin
  delete from user_iconpath where user_iconpath.id = pid;
  insert into user_iconpath values(pid,icon_path);
end
/$

create procedure submitForm(pid varchar(128), unitok varchar(128), json_form varchar(1024))
begin
  select count(*) from record_child where parent_token = unitok and student_id = pid into @matched_count;
  if @matched_count = 0 then
    select 'ERROR: students record did not exists';
  else
    select count(*) from record_form where record_form.parent_token = unitok into @IsFilled;
    if @IsFilled != 0 then
      delete from record_form where record_form.parent_token = unitok;
    end if;
    insert into record_form values(generate_unique_id(),unitok,pid,json_form);
    insert into record_child values(generate_unique_id(),unitok,pid,now(),1);
    select master_record.t_location into @location from master_record where master_record.token = unitok;
    insert into pop_list values(pid,@location,unitok,1);
    select 'SUCCESS: students form submitted!';
  end if;
end
/$

create procedure tagScanned(tagId varchar(128), location varchar(128))
begin
  /*CHECK IF TAGS VALID AND APPEND RECORD*/
  set @in_parent_token = null;
  set @out_parent_token = null;
  set @p_role = null;
  set @pid = null;
  select distinct tags_linkage.pid from tags_linkage where tags_linkage.tagId = tagId into @pid;
  if @pid = null then
    set @p_role = null;
  else
    select distinct personnel.p_role from personnel where id = @pid into @p_role;
  end if;
  if @p_role = 0 then
    delete from staff_location where staff_location.id = @pid;
    insert into staff_location values(@pid,now(),location);
    select 'SUCCESS: updated staff''s location';
  end if;
  if @p_role = 1 then
      select distinct record_child.parent_token into @in_parent_token from record_child where
        record_child.student_id = @pid and (select master_record.t_location from master_record where master_record.token = record_child.parent_token) = location and
        addtime(record_child.record_time,"00:25:30") >= now() and
        record_child.child_status = 0
        limit 1;

      select distinct record_child.parent_token from record_child where
        record_child.student_id = @pid and (select master_record.t_location from master_record where master_record.token = record_child.parent_token) = location and
        addtime(record_child.record_time,"00:25:30") >= now() and record_child.child_status = 1
        limit 1
        into @out_parent_token;

      if (@in_parent_token IS NOT NULL and @out_parent_token IS NULL) then
        insert into record_child values(generate_unique_id(),@in_parent_token,@pid,now(),2);
        select 'SUCCESS: appended one not sure child record';
      else
        if (@in_parent_token is null and @out_parent_token is null) or
        (@in_parent_token is not null and @out_parent_token is not null) then
          /*NO ANY RECORD*/
          set @unitok = generate_unique_id();
          insert into master_record values(generate_unique_id(),location,@unitok);
          insert into record_child values(generate_unique_id(),@unitok,@pid,now(),0);
          select 'SUCCESS: appended one master record';
          insert into pop_list values(@pid,location,@unitok,0);
        end if;

      end if;
  end if;
  if @p_role = 2 then
    delete from staff_location where staff_location.id = @pid;
    insert into staff_location values(@pid,now(),location);
    select 'SUCCESS: updated teacher''s location';
  end if;
  if @p_role is null then
    select 'ERROR: personnel unavail';
    /*INSERT RECOMMAND TAGS LOCATION LIST NOT REGISTERED*/
    delete from tags_location where tags_location.id = @pid and tags_location.location = location;
    insert into tags_location values(tagId,now(),location,false);
  else
    /*INSERT RECOMMAND TAGS LOCATION LIST REGISTERED*/
    delete from tags_location where tags_location.id = @pid and tags_location.location = location;
    insert into tags_location values(tagId,now(),location,true);
  end if;
end;
/$

create procedure linkTag(pid varchar(128),tagId varchar(128))
begin
  delete from tags_linkage where tags_linkage tagId = tagId;
  insert into tags_linkage values(pid,tagId);
end;
/$

create procedure addStudent(id varchar(64), name varchar(128), tagId varchar(64) , extra varchar(1024))
begin
  insert into personnel values(id,name,1,extra);
  insert into tags_linkage values(id,tagId);
end;
/$
DELIMITER ';';
