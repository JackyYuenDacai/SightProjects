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
            REFER TO questions_key_answer_key.txt
            REFER TO questions_key_answer_key.txt
            REFER TO questions_key_answer_key.txt
            form record:
              FirstChoice:A
              SecondChoice:B
            REFER TO questions_key_answer_key.txt
            call manAddRecord('0001','1980-01-01 00:00:00','1980-01-01 00:01:00','ABC',"{'FirstChoice':'A','SecondChoice':'B'}");
','ABC',"{'diaper':'na','mistake':'na','toilet':'wee',''poo':'na'}");
*/
/*
REFER TO questions_key_answer_key.txt
REFER TO questions_key_answer_key.txt
REFER TO questions_key_answer_key.txt
*
/*SAMPLE USERS*/
/*
call addStudent('0001','Kenya','0012','F01Y');
call addStudent('0002','Sabien','0013','F02Y2');
call addStudent('0003','Alexandrina','0014','F03Y3');
call addStudent('0004','Kelcey','0015','F04Y4');
call addStudent('0005','Bronwen','0016','F05Y1');
call addStudent('0006','Yana','0017','F06Y2');
call addStudent('0007','Militsa','0018','F06Y3');
call addStudent('0008','Ivona','0019','F06Y4');
call addStudent('0009','Ludmila','0020','F01Y2');
call addStudent('0010','Draga','0021','F02Y3');
call addStudent('0011','Maristella','0022','F03Y4');
call addStudent('0012','Maja','0023','F04Y5');
call addStudent('0013','Ester','0024','F05Y2');
call addStudent('0014','Lore','0025','F06Y5');
call addStudent('0015','Tordis','0026','F06Y6');
call addStudent('0016','Phaenna','0027','F06Y7');
call addStudent('0017','Asdis','0028','F01Y3');
call addStudent('0018','Karenza','0029','F02Y4');
call addStudent('0019','Lutgardis','0030','F03Y5');
call addStudent('0020','Lucile','0031','F04Y6');
call addStudent('0021','Gabriella','0032','F05Y3');
call addStudent('0022','Francoise','0033','F06Y8');
call addStudent('0023','Tofa','0034','F06Y9');
call addStudent('0024','Noelle','0035','F06Y10');
call addStudent('0025','Jewel','0036','F01Y4');
call addStudent('0026','Avelina','0037','F02Y5');
call addStudent('0027','Miloslava','0038','F03Y6');
call addStudent('0028','Sadia','0039','F04Y7');
call addStudent('0029','Aruna','0040','F05Y4');
call addStudent('0030','Inderjeet','0041','F06Y11');
call addStudent('0031','Frida','0042','F06Y12');
call addStudent('0032','Ea','0043','F06Y13');
call addStudent('0033','Betania','0044','F01Y5');
call addStudent('0034','Fae','0045','F02Y6');
call addStudent('0035','Odeta','0046','F03Y7');
call addStudent('0036','Nike','0047','F04Y8');
call addStudent('0037','Mirella','0048','F05Y5');
call addStudent('0038','Pauline','0049','F06Y14');
call addStudent('0039','Constantina','0050','F06Y15');
call addStudent('0040','Esme','0051','F06Y16');
call addStudent('0041','Isaias','0052','M01Y1');
call addStudent('0042','Min','0053','M02Y3');
call addStudent('0043','Cecilio','0054','M01Y2');
call addStudent('0044','Hrodger','0055','M02Y4');
call addStudent('0045','Preecha','0056','M01Y3');
call addStudent('0046','Andre','0057','M02Y5');
call addStudent('0047','Gobind','0058','M01Y4');
call addStudent('0048','Tonci','0059','M02Y6');
call addStudent('0049','Cipriano','0060','M01Y5');
call addStudent('0050','Blagoje','0061','M02Y7');
call addStudent('0051','Anton','0062','M01Y6');
call addStudent('0052','Taonga','0063','M02Y8');
call addStudent('0053','Sonam','0064','M01Y7');
call addStudent('0054','Orvar','0065','M02Y9');
call addStudent('0055','Razvan','0066','M01Y8');
call addStudent('0056','Atif','0067','M02Y10');
call addStudent('0057','Alte','0068','M01Y9');
call addStudent('0058','Carolus','0069','M02Y11');
call addStudent('0059','Eskender','0070','M01Y10');
call addStudent('0060','Jehu','0071','M02Y12');
call addStudent('0061','Abel','0072','M01Y11');
call addStudent('0062','Maurice','0073','M02Y13');
call addStudent('0063','Lakshmana','0074','M01Y12');
call addStudent('0064','Brandt','0075','M02Y14');
call addStudent('0065','Radek','0076','M01Y13');
call addStudent('0066','Ham','0077','M02Y15');
call addStudent('0067','Paulinho','0078','M01Y14');
call addStudent('0068','Jokull','0079','M02Y16');
call addStudent('0069','Gerold','0080','M01Y15');
call addStudent('0070','Sanjeet','0081','M02Y17');
call addStudent('0071','Chikere','0082','M01Y16');
call addStudent('0072','Ívarr','0083','M02Y18');
call addStudent('0073','Devadas','0084','M01Y17');
call addStudent('0074','Chayim','0085','M02Y19');
call addStudent('0075','Toni','0086','M01Y18');
call addStudent('0076','Prasanna','0087','M02Y20');
call addStudent('0077','Telesphorus','0088','M01Y19');
call addStudent('0078','Kourosh','0089','M02Y21');
call addStudent('0079','David','0090','M01Y20');
call addStudent('0080','Anselmo','0091','M02Y22');

insert into personnel values('1001','Billy a1',0,'M1');
insert into personnel values('1002','Abi a2',0,'F1');
insert into personnel values('1003','Billy b3',0,'M2');
insert into personnel values('1004','Abi b4',0,'F2');
insert into personnel values('1005','Billy a2',0,'M2');
insert into personnel values('1006','Abi a3',0,'F2');
insert into personnel values('1007','Billy b4',0,'M3');
insert into personnel values('1008','Abi b5',0,'F3');
insert into personnel values('1009','Billy a3',0,'M3');
insert into personnel values('1010','Abi a4',0,'F3');
insert into personnel values('1011','Billy b5',0,'M4');
insert into personnel values('1012','Abi b6',0,'F4');
insert into personnel values('1013','Billy a4',0,'M4');
insert into personnel values('1014','Abi a5',0,'F4');
insert into personnel values('1015','Billy b6',0,'M5');
insert into personnel values('1016','Abi b7',0,'F5');
insert into personnel values('1017','Billy a5',0,'M5');
insert into personnel values('1018','Abi a6',0,'F5');
insert into personnel values('1019','Billy b7',0,'M6');
insert into personnel values('1020','Abi b8',0,'F6');
insert into personnel values('1021','Billy a6',0,'M6');
insert into personnel values('1022','Abi a7',0,'F6');
insert into personnel values('1023','Billy b8',0,'M7');
insert into personnel values('1024','Abi b9',0,'F7');
insert into personnel values('1025','Billy a7',0,'M7');
insert into personnel values('1026','Abi a8',0,'F7');
insert into personnel values('1027','Billy b9',0,'M8');
insert into personnel values('1028','Abi b10',0,'F8');
insert into personnel values('1029','Billy a8',0,'M8');
insert into personnel values('1030','Abi a9',0,'F8');
insert into personnel values('1031','Billy b10',0,'M9');
insert into personnel values('1032','Abi b11',0,'F9');
insert into personnel values('1033','Billy a9',0,'M9');
insert into personnel values('1034','Abi a10',0,'F9');
insert into personnel values('1035','Billy b11',0,'M10');
insert into personnel values('1036','Abi b12',0,'F10');
insert into personnel values('1037','Billy a10',0,'M10');
insert into personnel values('1038','Abi a11',0,'F10');
insert into personnel values('1039','Billy b12',0,'M11');
insert into personnel values('1040','Abi b13',0,'F11');
insert into personnel values('1041','Billy a11',0,'M11');
insert into personnel values('1042','Abi a12',0,'F11');
insert into personnel values('1043','Billy b13',0,'M12');
insert into personnel values('1044','Abi b14',0,'F12');
insert into personnel values('1045','Billy a12',0,'M12');
insert into personnel values('1046','Abi a13',0,'F12');
insert into personnel values('1047','Billy b14',0,'M13');
insert into personnel values('1048','Abi b15',0,'F13');
insert into personnel values('1049','Billy a13',0,'M13');
insert into personnel values('1050','Abi a14',0,'F13');
insert into personnel values('1051','Billy b15',0,'M14');
insert into personnel values('1052','Abi b16',0,'F14');
insert into personnel values('1053','Billy a14',0,'M14');
insert into personnel values('1054','Abi a15',0,'F14');
insert into personnel values('1055','Billy b16',0,'M15');
insert into personnel values('1056','Abi b17',0,'F15');
insert into personnel values('1057','Billy a15',0,'M15');
insert into personnel values('1058','Abi a16',0,'F15');
insert into personnel values('1059','Billy b17',0,'M16');
insert into personnel values('1060','Abi b18',0,'F16');
insert into personnel values('1061','Billy a16',0,'M16');
insert into personnel values('1062','Abi a17',0,'F16');
insert into personnel values('1063','Billy b18',0,'M17');
insert into personnel values('1064','Abi b19',0,'F17');
insert into personnel values('1065','Billy a17',0,'M17');
insert into personnel values('1066','Abi a18',0,'F17');
insert into personnel values('1067','Billy b19',0,'M18');
insert into personnel values('1068','Abi b20',0,'F18');
insert into personnel values('1069','Billy a18',0,'M18');
insert into personnel values('1070','Abi a19',0,'F18');
insert into personnel values('1071','Billy b20',0,'M19');
insert into personnel values('1072','Abi b21',0,'F19');
insert into personnel values('1073','Billy a19',0,'M19');
insert into personnel values('1074','Abi a20',0,'F19');
insert into personnel values('1075','Billy b21',0,'M20');
insert into personnel values('1076','Abi b22',0,'F20');
insert into personnel values('1077','Billy a20',0,'M20');
insert into personnel values('1078','Abi a21',0,'F20');
insert into personnel values('1079','Billy b22',0,'M21');
insert into personnel values('1080','Abi b23',0,'F21');
insert into tags_linkage values('1001','0121');
insert into tags_linkage values('1002','0122');
insert into tags_linkage values('1003','0123');
insert into tags_linkage values('1004','0124');
insert into tags_linkage values('1005','0125');
insert into tags_linkage values('1006','0126');
insert into tags_linkage values('1007','0127');
insert into tags_linkage values('1008','0128');
insert into tags_linkage values('1009','0129');
insert into tags_linkage values('1010','0130');
insert into tags_linkage values('1011','0131');
insert into tags_linkage values('1012','0132');
insert into tags_linkage values('1013','0133');
insert into tags_linkage values('1014','0134');
insert into tags_linkage values('1015','0135');
insert into tags_linkage values('1016','0136');
insert into tags_linkage values('1017','0137');
insert into tags_linkage values('1018','0138');
insert into tags_linkage values('1019','0139');
insert into tags_linkage values('1020','0140');
insert into tags_linkage values('1021','0141');
insert into tags_linkage values('1022','0142');
insert into tags_linkage values('1023','0143');
insert into tags_linkage values('1024','0144');
insert into tags_linkage values('1025','0145');
insert into tags_linkage values('1026','0146');
insert into tags_linkage values('1027','0147');
insert into tags_linkage values('1028','0148');
insert into tags_linkage values('1029','0149');
insert into tags_linkage values('1030','0150');
insert into tags_linkage values('1031','0151');
insert into tags_linkage values('1032','0152');
insert into tags_linkage values('1033','0153');
insert into tags_linkage values('1034','0154');
insert into tags_linkage values('1035','0155');
insert into tags_linkage values('1036','0156');
insert into tags_linkage values('1037','0157');
insert into tags_linkage values('1038','0158');
insert into tags_linkage values('1039','0159');
insert into tags_linkage values('1040','0160');
insert into tags_linkage values('1041','0161');
insert into tags_linkage values('1042','0162');
insert into tags_linkage values('1043','0163');
insert into tags_linkage values('1044','0164');
insert into tags_linkage values('1045','0165');
insert into tags_linkage values('1046','0166');
insert into tags_linkage values('1047','0167');
insert into tags_linkage values('1048','0168');
insert into tags_linkage values('1049','0169');
insert into tags_linkage values('1050','0170');
insert into tags_linkage values('1051','0171');
insert into tags_linkage values('1052','0172');
insert into tags_linkage values('1053','0173');
insert into tags_linkage values('1054','0174');
insert into tags_linkage values('1055','0175');
insert into tags_linkage values('1056','0176');
insert into tags_linkage values('1057','0177');
insert into tags_linkage values('1058','0178');
insert into tags_linkage values('1059','0179');
insert into tags_linkage values('1060','0180');
insert into tags_linkage values('1061','0181');
insert into tags_linkage values('1062','0182');
insert into tags_linkage values('1063','0183');
insert into tags_linkage values('1064','0184');
insert into tags_linkage values('1065','0185');
insert into tags_linkage values('1066','0186');
insert into tags_linkage values('1067','0187');
insert into tags_linkage values('1068','0188');
insert into tags_linkage values('1069','0189');
insert into tags_linkage values('1070','0190');
insert into tags_linkage values('1071','0191');
insert into tags_linkage values('1072','0192');
insert into tags_linkage values('1073','0193');
insert into tags_linkage values('1074','0194');
insert into tags_linkage values('1075','0195');
insert into tags_linkage values('1076','0196');
insert into tags_linkage values('1077','0197');
insert into tags_linkage values('1078','0198');
insert into tags_linkage values('1079','0199');
insert into tags_linkage values('1080','0200');
*/
call addStudent('0021','Gabriella','0032','F05Y3');
/*SAMPLE RECORDS*/
/*
call manAddRecord('0021','2018-09-17 06:43:20','2018-09-17 06:52:35','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-17 08:33:42','2018-09-17 08:42:57','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-17 10:11:50','2018-09-17 10:21:05','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-17 10:22:50','2018-09-17 10:32:05','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-17 10:23:13','2018-09-17 10:32:28','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-17 10:56:09','2018-09-17 11:05:24','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-17 12:23:27','2018-09-17 12:32:42','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-17 12:41:14','2018-09-17 12:50:29','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-17 12:53:51','2018-09-17 13:03:06','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-17 14:26:30','2018-09-17 14:35:45','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-17 14:54:59','2018-09-17 15:04:14','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-17 21:00:27','2018-09-17 21:09:42','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-18 09:20:42','2018-09-18 09:29:57','ABC',"{'diaper':'dirty','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-18 10:01:09','2018-09-18 10:10:24','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-18 10:34:25','2018-09-18 10:43:40','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-18 12:16:35','2018-09-18 12:25:50','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-18 12:47:13','2018-09-18 12:56:28','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-18 12:56:05','2018-09-18 13:05:20','ABC',"{'diaper':'na','mistake':'wee','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-18 14:21:45','2018-09-18 14:31:00','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-18 15:02:09','2018-09-18 15:11:24','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-18 15:25:05','2018-09-18 15:34:20','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-18 16:04:22','2018-09-18 16:13:37','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-18 18:47:22','2018-09-18 18:56:37','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-18 21:04:42','2018-09-18 21:13:57','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-19 10:43:42','2018-09-19 10:52:57','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-19 11:59:49','2018-09-19 12:09:04','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-19 12:38:17','2018-09-19 12:47:32','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-19 13:41:00','2018-09-19 13:50:15','ABC',"{'diaper':'na','mistake':'na','toilet':'both','poo':'normal','poo_consistency':'hard','poo_color_yellow':'true','poo_color_brown':'false','poo_color_black':'false','poo_consist_blood':'false','poo_consist_goo':'false'}");
call manAddRecord('0021','2018-09-19 15:09:20','2018-09-19 15:18:35','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-19 16:31:15','2018-09-19 16:40:30','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-19 17:04:42','2018-09-19 17:13:57','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-19 17:30:42','2018-09-19 17:39:57','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-19 18:00:26','2018-09-19 18:09:41','ABC',"{'diaper':'na','mistake':'wee','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-19 20:30:42','2018-09-19 20:39:57','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-19 21:04:42','2018-09-19 21:13:57','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-20 09:42:32','2018-09-20 09:51:47','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-20 10:12:31','2018-09-20 10:21:46','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-20 13:43:36','2018-09-20 13:52:51','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-20 14:21:13','2018-09-20 14:30:28','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-20 15:03:29','2018-09-20 15:12:44','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-20 15:31:15','2018-09-20 15:40:30','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-20 17:30:42','2018-09-20 17:39:57','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-20 18:30:26','2018-09-20 18:39:41','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-20 20:00:42','2018-09-20 20:09:57','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-20 21:04:42','2018-09-20 21:13:57','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-21 08:48:01','2018-09-21 08:57:16','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-21 09:17:40','2018-09-21 09:26:55','ABC',"{'diaper':'na','mistake':'wee','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-21 10:10:16','2018-09-21 10:19:31','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-21 11:18:00','2018-09-21 11:27:15','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-21 14:41:45','2018-09-21 14:51:00','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-21 16:27:48','2018-09-21 16:37:03','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-22 06:51:53','2018-09-22 07:01:08','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-22 09:16:34','2018-09-22 09:25:49','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-22 12:21:42','2018-09-22 12:30:57','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-22 14:40:49','2018-09-22 14:50:04','ABC',"{'diaper':'na','mistake':'na','toilet':'both','poo':'normal','poo_consistency':'soft','poo_color_yellow':'false','poo_color_brown':'true','poo_color_black':'false','poo_consist_blood':'false','poo_consist_goo':'false'}");
call manAddRecord('0021','2018-09-22 15:31:03','2018-09-22 15:40:18','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-22 16:02:59','2018-09-22 16:12:14','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-22 18:31:55','2018-09-22 18:41:10','ABC',"{'diaper':'na','mistake':'na','toilet':'both','poo':'much','poo_consistency':'hard','poo_color_yellow':'false','poo_color_brown':'true','poo_color_black':'false','poo_consist_blood':'true','poo_consist_goo':'false'}");
call manAddRecord('0021','2018-09-22 21:02:03','2018-09-22 21:11:18','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-22 21:25:05','2018-09-22 21:34:20','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-23 07:25:27','2018-09-23 07:34:42','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-23 09:09:13','2018-09-23 09:18:28','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-23 09:30:51','2018-09-23 09:40:06','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-23 10:11:12','2018-09-23 10:20:27','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-23 12:00:33','2018-09-23 12:09:48','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-23 12:31:08','2018-09-23 12:40:23','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-23 12:38:58','2018-09-23 12:48:13','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-23 13:01:37','2018-09-23 13:10:52','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-23 13:39:00','2018-09-23 13:48:15','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-23 13:59:11','2018-09-23 14:08:26','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-23 15:48:42','2018-09-23 15:57:57','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-23 21:45:06','2018-09-23 21:54:21','ABC',"{'diaper':'na','mistake':'na','toilet':'poo','poo':'much','poo_consistency':'soft','poo_color_yellow':'false','poo_color_brown':'true','poo_color_black':'false','poo_consist_blood':'false','poo_consist_goo':'false'}");
call manAddRecord('0021','2018-09-23 21:47:29','2018-09-23 21:56:44','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-23 22:43:53','2018-09-23 22:53:08','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-23 23:00:15','2018-09-23 23:09:30','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-24 09:42:55','2018-09-24 09:52:10','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-24 09:54:06','2018-09-24 10:03:21','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-24 10:31:07','2018-09-24 10:40:22','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-24 10:54:24','2018-09-24 11:03:39','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-24 11:04:57','2018-09-24 11:14:12','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-24 12:54:13','2018-09-24 13:03:28','ABC',"{'diaper':'na','mistake':'wee','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-24 13:13:28','2018-09-24 13:22:43','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-24 15:28:50','2018-09-24 15:38:05','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-24 18:19:03','2018-09-24 18:28:18','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-24 19:23:02','2018-09-24 19:32:17','ABC',"{'diaper':'dirty','mistake':'poo','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 10:00:39','2018-09-25 10:09:54','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 11:00:31','2018-09-25 11:09:46','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 12:00:19','2018-09-25 12:09:34','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 13:00:39','2018-09-25 13:09:54','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 14:00:12','2018-09-25 14:09:27','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 15:00:39','2018-09-25 15:09:54','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 16:00:11','2018-09-25 16:09:26','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 17:55:29','2018-09-25 18:04:44','ABC',"{'diaper':'na','mistake':'na','toilet':'poo','poo':'much','poo_consistency':'soft','poo_color_yellow':'false','poo_color_brown':'true','poo_color_black':'false','poo_consist_blood':'false','poo_consist_goo':'false'}");
call manAddRecord('0021','2018-09-25 18:30:35','2018-09-25 18:39:50','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 18:35:47','2018-09-25 18:45:02','ABC',"{'diaper':'na','mistake':'both','toilet':'wee','poo':'normal','poo_consistency':'soft','poo_color_yellow':'true','poo_color_brown':'false','poo_color_black':'false','poo_consist_blood':'false','poo_consist_goo':'false'}");
call manAddRecord('0021','2018-09-25 18:37:55','2018-09-25 18:47:10','ABC',"{'diaper':'na','mistake':'poo','toilet':'na','poo':'normal','poo_consistency':'soft','poo_color_yellow':'false','poo_color_brown':'true','poo_color_black':'false','poo_consist_blood':'false','poo_consist_goo':'false'}");
call manAddRecord('0021','2018-09-25 19:05:56','2018-09-25 19:15:11','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 19:35:40','2018-09-25 19:44:55','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 20:15:20','2018-09-25 20:24:35','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 21:01:11','2018-09-25 21:10:26','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 21:01:26','2018-09-25 21:10:41','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 21:28:16','2018-09-25 21:37:31','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 21:32:16','2018-09-25 21:41:31','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-25 22:05:46','2018-09-25 22:15:01','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-26 13:08:50','2018-09-26 13:18:05','ABC',"{'diaper':'na','mistake':'wee','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-26 13:38:58','2018-09-26 13:48:13','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-26 15:08:28','2018-09-26 15:17:43','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-26 16:00:11','2018-09-26 16:09:26','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-26 17:00:11','2018-09-26 17:09:26','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-26 18:15:23','2018-09-26 18:24:38','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-26 19:00:12','2018-09-26 19:09:27','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-26 20:15:33','2018-09-26 20:24:48','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-26 21:00:11','2018-09-26 21:09:26','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-27 09:12:27','2018-09-27 09:21:42','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-27 13:33:24','2018-09-27 13:42:39','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-27 13:54:30','2018-09-27 14:03:45','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-27 14:46:12','2018-09-27 14:55:27','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-27 15:05:22','2018-09-27 15:14:37','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-27 16:00:11','2018-09-27 16:09:26','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-27 17:00:11','2018-09-27 17:09:26','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-27 18:15:23','2018-09-27 18:24:38','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-27 19:00:12','2018-09-27 19:09:27','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-27 20:15:33','2018-09-27 20:24:48','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-27 21:00:11','2018-09-27 21:09:26','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-28 08:00:25','2018-09-28 08:09:40','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-28 10:17:37','2018-09-28 10:26:52','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-28 11:12:21','2018-09-28 11:21:36','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-28 13:06:48','2018-09-28 13:16:03','ABC',"{'diaper':'na','mistake':'wee','toilet':'na','poo':'na'}");
call manAddRecord('0021','2018-09-28 14:39:42','2018-09-28 14:48:57','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-28 14:53:32','2018-09-28 15:02:47','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-28 16:00:11','2018-09-28 16:09:26','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-28 17:00:11','2018-09-28 17:09:26','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-28 18:15:23','2018-09-28 18:24:38','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-28 19:00:12','2018-09-28 19:09:27','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-28 20:15:33','2018-09-28 20:24:48','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-28 21:00:11','2018-09-28 21:09:26','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-29 10:03:36','2018-09-29 10:12:51','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-29 11:03:36','2018-09-29 11:12:51','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-29 13:03:36','2018-09-29 13:12:51','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-29 14:03:36','2018-09-29 14:12:51','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-29 15:30:36','2018-09-29 15:39:51','ABC',"{'diaper':'na','mistake':'na','toilet':'poo','poo':'much','poo_consistency':'soft','poo_color_yellow':'false','poo_color_brown':'true','poo_color_black':'false','poo_consist_blood':'false','poo_consist_goo':'false'}");
call manAddRecord('0021','2018-09-29 21:42:59','2018-09-29 21:52:14','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-30 06:36:16','2018-09-30 06:45:31','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-30 09:24:05','2018-09-30 09:33:20','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-30 12:57:58','2018-09-30 13:07:13','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
call manAddRecord('0021','2018-09-30 17:21:11','2018-09-30 17:30:26','ABC',"{'diaper':'na','mistake':'na','toilet':'wee','poo':'na'}");
*/
