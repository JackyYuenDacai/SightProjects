DELIMITER ';'

/*
MYSQL SCRIPT
FUNCTION UTILS
*/

DELIMITER '/$'

create function generate_unique_id()
returns varchar(128)
begin
  set @id = md5(TO_BASE64(now()+rand()));
  while (select count(*) from id_list where id_list.id = @id) > 0 do
    set @id = md5(TO_BASE64(now()+rand()));
  end while;
  insert into id_list values(@id);
  return(@id);
end
/$

DELIMITER ';';
