import 'package:json_annotation/json_annotation.dart';
import 'columnWidget.dart';
import 'package:intl/intl.dart';
import 'DataForm.dart';
class pop{
  pop(this.name,this.id,this.status,this.unitok);
  final String name;
  final String id;
  final String status;
  final String unitok;
  factory pop.fromJson(Map<String,dynamic> json){
    return new pop(json['name'],
      json['id'],
      json['status'],
      json['unitok'],
    );
  }
}

class popList{
  final List<pop> Pops;
  popList({this.Pops,});
  factory popList.fromJson(List<dynamic> json){
    List<pop> Pops = new List<pop>();
    Pops = json.map((i)=>pop.fromJson(i)).toList();
    return new popList(Pops:Pops);
  }
}
class staff{
  staff(this.id,this.name);
  final String name;
  final String id;

  factory staff.fromJson(Map<String,dynamic> json){
    return new staff(json['id'],json['name']);
  }
}

class staffList{
  final List<staff> Staffs;
  staffList({this.Staffs,});
  factory staffList.fromJson(List<dynamic> json){
    List<staff> Staffs = new List<staff>();
    Staffs = json.map((i)=>staff.fromJson(i)).toList();
    return new staffList(Staffs:Staffs);
  }
}

class Tag{
  final String id;
  Tag(this.id);
  factory Tag.fromJson(Map<String,dynamic> json){
    return new Tag(json['id']);
  }
}
class tagList{
  final List<Tag> tags;
  tagList({this.tags});
  factory tagList.fromJson(List<dynamic> json){
    List<Tag> tags = new List<Tag>();
    tags = json.map((i)=>Tag.fromJson(i)).toList();
    return new tagList(tags:tags);
  }
}
class student{
  student(this.id,this.name);
  final String name;
  final String id;

  factory student.fromJson(Map<String,dynamic> json){
    return new student(json['id'],json['name']);
  }
}
class studentList{
  final List<student> Staffs;
  studentList({this.Staffs,});
  factory studentList.fromJson(List<dynamic> json){
    List<student> Staffs = new List<student>();
    Staffs = json.map((i)=>student.fromJson(i)).toList();
    return new studentList(Staffs:Staffs);
  }
}

class record_entry{
  final DateTime time_in;
  final DateTime interval;
  final String location;
  final Map<String,dynamic> data_json;
  record_entry(this.time_in,this.interval,this.location,this.data_json);
  factory record_entry.fromJson(Map<String,dynamic> json){
    return new record_entry(
      new DateFormat("yyyy-MM-dd HH:mm:ss").parse(json['time']),
      new DateFormat("HH:mm:ss").parse(json['interval']),
      json['location'],
      json['data_json']);
  }
}
class record_entries{
  final List<record_entry> entries;
  record_entries({this.entries});
  factory record_entries.fromJson(List<dynamic> json){
    List<record_entry> entries = new List<record_entry>();
    entries = json.map((i)=>record_entry.fromJson(i)).toList();
    return new record_entries(entries:entries);
  }
}
class question{
  String title;
  String id;
  List<String> answer;
  List<String> answer_id;
  int type = 0;
  /*
   * To dynamically spread questions
   * Type 0: Multiple choice one choice
   * Type 1: Check box true or false
   * Type 2: Text label
   */
  question(this.title,this.id,this.answer,this.answer_id,[this.type=0]);
}

class StaticList{
  static List<ColForm> colform_list = new List<ColForm>();
  static List<DataForm> datform_list = new List<DataForm>();
  static String location = 'A';
  static record_entries entries;
  static List<String> student_id = new List<String>();
  static List<String> student_name = new List<String>();

  static List<String> staff_id = new List<String>();
  static List<String> staff_list = new List<String>();

  static List<String> tag_list = new List<String>();

  static String server_addr = 'http://192.168.31.2:8080';//'http://192.168.31.2:8080';
  static String getpop_api_url = server_addr+'/WebInterface/get_pops_list?location=';
  static String getstaff_api_url = server_addr+'/WebInterface/get_staff_list?location=';
  static String submit_form_api_url = server_addr+'/WebInterface/submit_form?';
  static String get_student_list = server_addr+'/WebInterface/get_student_list';
  static String get_record_data_url = server_addr+'/WebInterface/getRecordData?';
  static String get_tags_url = server_addr+'/WebInterface/get_tags_list?location=';
  static String add_student_api_url = server_addr+'/WebInterface/add_student?';
  static String del_student_api_url = server_addr+'/WebInterface/del_student?';
  static String get_record_export_url = server_addr+'/WebInterface/record_export?';
  static String add_staff_api_url = server_addr+'/WebInterface/add_staff?';
  static List<question> QuestionList = <question>[
    new question('Check','diaper',<String>['N/A','Clean','Dirty'],<String>['na','clean','dirty'],0),
    new question('Mistake','mistake',<String>['N/A','Wee','Poo','Both'],<String>['na','wee','poo','both'],0),
    new question('Toilet','toilet',<String>['N/A','Nothing','Wee','Poo','Both'],<String>['na','nothing','wee','poo','both'],0),
    new question('Poo','poo',<String>['N/A','Few','Normal','Much'],<String>['na','few','normal','much'],0),
    new question('Consistency','poo_consistency',<String>['Soft','Hard','Rot','Dilute'],<String>['soft','hard','rot','dilute'],0),
    new question('Color','poo_color',<String>['true','false'],<String>['true','false'],2),
    new question('Yellow','poo_color_yellow',<String>['true','false'],<String>['true','false'],1),
    new question('Brown','poo_color_brown',<String>['true','false'],<String>['true','false'],1),
    new question('Black','poo_color_black',<String>['true','false'],<String>['true','false'],1),
    new question('Blood','poo_consist_blood',<String>['true','false'],<String>['true','false'],1),
    new question('Goo','poo_consist_goo',<String>['true','false'],<String>['true','false'],1),
  ];

}
