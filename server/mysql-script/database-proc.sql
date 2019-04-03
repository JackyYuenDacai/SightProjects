DELIMITER ';'
uses caritas_main;

/*drop procedures to update*/
IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = 'caritas_main'
    AND SPECIFIC_NAME = 
)
DROP PROCEDURE SchemaName.StoredProcedureName
GO

DELIMITER '/$'
/*procedures to be added*/

CREATE FUNCTION gen_id()--This will generate a unique id for each eventRETURNS VARCHAR(64)
BEGIN
    SET @id = md5(TO_BASE64(now()+rand()));
    while (SELECT count(*) FROM id_list WHERE id_list.id = @id) > 0 do
        SET @id = md5(TO_BASE64(now()+rand()));
    END while
    INSERT INTO id_list VALUE(@id);
    RETURNS varchar(64)
    RETURN @id;
END /$

CREATE PROCEDURE insert_in(id, t_location,token)--This will allow data to be inserted when a tag is sensed 
BEGIN
    --SET @token = (SELECT count(*) FROM master_record)
    INSERT INTO master_record VALUE(id,t_location,@token)
END /$

CREATE PROCEDURE insert_record_child(id,this_parent_token,here)
BEGIN   
    SET @student_id = --to be finished
    IF(SELECT count(*) FROM record_child WHERE parent_token=this_parent_token > 0) THEN
        INSERT INTO record_child(id,student_id, child_status) VALUES (id,@student_id, 0);
    ELSE IF (here=1)
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


