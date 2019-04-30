import 'package:json_annotation/json_annotation.dart';
import 'columnWidget.dart';
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

class StaticList{
  static List<ColForm> colform_list = new List<ColForm>();
  static String location = 'A';

  static List<String> student_id = new List<String>();
  static List<String> student_name = new List<String>();

  static List<String> staff_id = new List<String>();
  static List<String> staff_list = new List<String>();
  static String server_addr = 'http://localhost:8080';//'http://192.168.31.2:8080';
  static String getpop_api_url = server_addr+'/WebInterface/get_pops_list?location=';
  static String getstaff_api_url = server_addr+'/WebInterface/get_staff_list?location=';
  static String submit_form_api_url = server_addr+'/WebInterface/submit_form?';
  static String get_student_list = server_addr+'/WebInterface/get_student_list';
  static String get_record_data_url = server_addr+'/WebInterface/getRecordData?';
}
