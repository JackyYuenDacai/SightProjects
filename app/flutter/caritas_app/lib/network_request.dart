import 'pop.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'columnWidget.dart';
typedef ProcessFunc = void Function(http.Response);
class network_request{

  static var client = new http.Client();

  static http.Response ajaxResponse = new http.Response("",200);
  static String server_addr = 'http://localhost:8080';//'http://192.168.31.2:8080';
  static String getpop_api_url = server_addr+'/WebInterface/get_pops_list?location=';
  static String getstaff_api_url = server_addr+'/WebInterface/get_staff_list?location=';
  static String submit_form_api_url = server_addr+'/WebInterface/submit_form?';
  static String get_student_list = server_addr+'/WebInterface/get_student_list';
  static String get_record_data_url = server_addr+'/WebInterface/getRecordData?';
  static String get_tags_url = server_addr+'/WebInterface/get_tags_list?location=';
  static String add_student_api_url = server_addr+'/WebInterface/add_student?';
  static String del_student_api_url = server_addr+'/WebInterface/del_student?';
  static String get_record_export_url = server_addr+'/WebInterface/record_export?';

  static void get_staff_list(String location){
    var url = StaticList.getstaff_api_url+location;
    requestWrap(url,(response)=>get_staff_list_proc(response));
  }
  static void get_pop_list(String location){
    var url = StaticList.getpop_api_url+location;
    requestWrap(url,(response)=>get_pop_list_proc(response));
  }

  static void requestWrap(String url,ProcessFunc process) async{
    await client.get(url)
        .then((response) {
          if(response.body.length<=0){
            return;
          }
          ajaxResponse = response;
          process(response);
    });
  }
  static void get_pop_list_proc(http.Response response){
    if(response.body.length<=0)
      return;
    popList pops = new popList.fromJson(json.decode(response.body));
    for(pop wid in pops.Pops){
        if(wid.status == "0"){
            StaticList.colform_list.add(new ColForm(wid.name,wid.id,wid.unitok));
            print("added colform ${wid.name} ${wid.id} ${wid.unitok}");
        }else if(wid.status == "1"){
          for(var obj in StaticList.colform_list){
            if(obj.name == wid.name){
              StaticList.colform_list.remove(obj);
              print("deleted colform ${wid.name} ${wid.id} ${wid.unitok}");
              break;
            }
          }
        }
    }
  }
  static void get_staff_list_proc(http.Response response){
    if(response.body.length<=0)
      return;
    staffList staffs = new staffList.fromJson(json.decode(response.body));
    StaticList.staff_id.clear();
    StaticList.staff_list.clear();
    for(staff wid in staffs.Staffs){
        StaticList.staff_id.add(wid.id);
        print('name:'+wid.name);
        StaticList.staff_list.add(wid.name);
    }
  }


}
