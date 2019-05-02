/*
manAddRecord(id varchar(64),time_in DateTime,time_out Datetime,location varchar(64),data_json varchar(1024))
  time format Year Month Day Hour Min second
  'yyyy-mm-dd hh:mm:ss'
addStudent(id varchar(64), name varchar(128), tagId varchar(64) , extra varchar(1024))
*/
/*
  EXAMPLES
  Add student named:Abi
              id: 0001
              predefined tagId:0011
              extra: extra info
            call addStudent('0001','Abi','0011','extra info')
  Add staff named:Billy
            id: 0002
            predefined tagId:0121
            extra: extra info
          insert into personnel values('0002','Billy',0,'extra info');
          insert into tags_linkage values('0002','0121');

  Add record manuely
            time  in 1980-01-01 00:00:00
            time out 1980-01-01 00:01:00
            location ABC
            form record:
              FirstChoice:A
              SecondChoice:B
            call manAddRecord('0001','1980-01-01 00:00:00','1980-01-01 00:01:00','ABC',"{'FirstChoice':'A','SecondChoice':'B'}");

*/
/*

diaper:
  N/A
  clean
  dirty


*
/*SAMPLE USERS*/

/*SAMPLE RECORDS*/
