import 'pop.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'columnWidget.dart';
import 'package:json_annotation/json_annotation.dart';
typedef ProcessFunc = void Function(http.Response);
class network_request{

  static var client = new http.Client();

  static http.Response ajaxResponse = new http.Response("",200);
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
  static void get_staff_list(String location){
    var url = StaticList.getstaff_api_url+location;
    requestWrap(url,(response)=>get_staff_list_proc(response));
  }
  static void get_pop_list(String location){
    var url = StaticList.getpop_api_url+location;
    requestWrap(url,(response)=>get_pop_list_proc(response));
  }
  static void get_record_data(String id, String time)async{
    var url = StaticList.get_record_data_url+"id="+id+"&time=${time}";
    await requestWrap(url,(response)=>get_record_data_proc(response));
  }
  static void post_submit_form(String id,String unitok,Map<String,String> json_data){
    var url = StaticList.submit_form_api_url;
    url = url + 'id=' + id +'&';
    url = url + 'unitok=' + unitok +'&';
    postWrap(url,{
        HttpHeaders.contentTypeHeader: "application/json",
        "callMethod" : "DOCTOR_AVAILABILITY"
      },
      json.encode(json_data),
      (response){
        if(response.body == 'success'){
          for(ColForm a in StaticList.colform_list){
            if(a.id == id){
              StaticList.colform_list.remove(a);
              break;
            }
          }
        }
        ;
      });
  }
  static void requestWrap(String url,ProcessFunc process) async{

    await http.get(url)
        .then((response) {
          if(response.body.length<=0){
            return;
          }
          if(response.statusCode != 200){
            print('Server exception');
            print(response.body);
            return;
          }
          ajaxResponse = response;
          process(response);
    });
  }
  static void postWrap(String url,var header,var body_data, ProcessFunc process) async{
    print(body_data);
    print(url);
    await http.post(
      url,
      body:body_data,
      headers:header
    ).then((response) {
      if(response.body.length<=0){
        return;
      }
      if(response.statusCode != 200){
        print('Server exception');
        print(response.body);
        return;
      }
      ajaxResponse = response;
      process(response);
    });
  }
  static void get_record_data_proc(http.Response response){
    //print("Response body: ${response.body}");

    StaticList.entries = new record_entries.fromJson(json.decode(response.body));
  }
  static void get_pop_list_proc(http.Response response){
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
