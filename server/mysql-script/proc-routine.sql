DELIMITER ';'

/*
MYSQL SCRIPT
PROCEDURE ROUTINE EVENT
*/

DELIMITER '/$'

create procedure RoutineCheck()
begin
  truncate table tmp_list;
  select count(distinct record_child.parent_token) from record_child where
    addtime(record_child.record_time,"96:00:00") >= now() and
    addtime(record_child.record_time,"00:25:30") < now()
    into @expired_record_count;
  insert into tmp_list(token) select distinct record_child.parent_token as token  from record_child where
    addtime(record_child.record_time,"96:00:00") >= now() and
    addtime(record_child.record_time,"00:25:30") < now()
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

create event Event_Second
on schedule
every 30 second
do call RoutineCheck();
/$

DELIMITER '/$'
