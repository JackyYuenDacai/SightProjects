DELIMITER ';'
uses caritas_main;
/*drop procedures to update*/

DELIMITER '/$'
/*procedures to be added*/

CREATE PROCEDURE gen_id()
BEGIN
set @id = md5(TO_BASE64(now()+rand()));
  while (select count(*) from id_list where id_list.id = @id) > 0 do
    set @id = md5(TO_BASE64(now()+rand()));
  END while
END
/$







DELIMITER ';'


