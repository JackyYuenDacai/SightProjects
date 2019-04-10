DELIMITER ';'
USE caritas_main;

/*drop procedures to update*/
/*IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = 'caritas_main'
    AND SPECIFIC_NAME = 
)
DROP PROCEDURE SchemaName.StoredProcedureName
GO*/

DELIMITER '/$'
/*procedures to be added*/

CREATE FUNCTION gen_id() #This will generate a unique id for each event
BEGIN
    @random= SELECT RAND();
    SET @id = md5(TO_BASE64(now()+ @random);
    while (SELECT count(*) FROM id_list WHERE id_list.id = @id) > 0 do
        @random= SELECT RAND();
        SET @id = md5(TO_BASE64(now()+@random);
    END while
    INSERT INTO id_list VALUE(@id);
    RETURNS VARCHAR(64)
    RETURN @id;
END /$

CREATE FUNCTION tag_record(t_location,token,this_id) /*#This will allow data to be inserted when a tag is sensed*/
RETURNS VARCHAR(64)  
BEGIN
    SET token = gen_id();
    INSERT INTO master_record VALUE(id,t_location,token);
    @p_role= SELECT p_role FROM personnel WHERE id=this_id;
    IF @p_role = 1 THEN
		insert_record_child(token,this_id);
	RETURN id # It will return the parent token for other tables
END /$

CREATE PROCEDURE submit_form(token,s_id,answer) #That's what to be called as a survey is submitted
BEGIN
	insert_record_child(token,s_id);
    @id = gen_id();
    INSERT INTO record_form(@id,token,s_id,answer);
END /$

CREATE PROCEDURE insert_record_child(this_parent_token,student_id) #That's to handle record_child; will only be called by other stored rountines
BEGIN   
	SET id = gen_id();
    IF(SELECT count(*) FROM record_child WHERE parent_token=this_parent_token > 0) THEN
        UPDATE record_child SET child_status = 0 WHERE parent_token=this_parent_token;
        INSERT INTO record_child(id,student_id, child_status) VALUES (id,@student_id, 1);
    ELSE
        INSERT INTO record_child(id,student_id, child_status) VALUES (id,@student_id, 2);
END /$


	



-- Create a new stored procedure called 'StoredProcedureName' in schema 'SchemaName'
-- Drop the stored procedure if it already exists
/*
IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'SchemaName'
    AND SPECIFIC_NAME = N'StoredProcedureName'
)
DROP PROCEDURE SchemaName.StoredProcedureName
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE SchemaName.StoredProcedureName
    --@param1 /*parameter name*/ --int /*datatype_for_param1*/-- = 0, /*default_value_for_param1*/
    --@param2 /*parameter name*/ int /*datatype_for_param1*/-- = 0 /*default_value_for_param2*/
-- add more stored procedure parameters here
/*
AS
    -- body of the stored procedure
    SELECT @param1, @param2
GO
-- example to execute the stored procedure we just created
EXECUTE SchemaName.StoredProcedureName 1 /*value_for_param1*/--, 2 /*value_for_param2*/
--GO

DELIMITER ';'


