import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:async/async.dart';
import './columnWidget.dart';
import './RFIDPage.dart';
import './ManPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './pop.dart';
import './DataForm.dart';
class DataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DataPageState();
  }
}

class _DataPageState extends State<DataPage> {
  http.Response ajaxResponse = new http.Response("",200);
  List<DataForm> datform_list = new List<DataForm>();
  initState(){
    super.initState();
    ajaxResponse = new http.Response("",200);;
    var url = StaticList.get_student_list;
    //print(url);
    http.get(url)
        .then((response) {
      //print("Response status: ${response.statusCode}");

          print("Response body: ${response.body}");
          print('get student list');
          if(response.body.length<=0){
            return;
          }
          studentList staffs = new studentList.fromJson(json.decode(response.body));
          StaticList.student_id.clear();
          StaticList.student_name.clear();
          for(student wid in staffs.Staffs){
            this.setState((){
              StaticList.student_id.add(wid.id);
              print('name:'+wid.name);
              StaticList.student_name.add(wid.name);
              datform_list.add(new DataForm(wid.name,wid.id));
            });
          }

          //ajaxCall.reset();
    });
    //print("Response body:${ajaxResponse.body}");
    if(this.ajaxResponse.body.length <= 0){
      //ajaxCall.reset();
      //return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget userHeader = UserAccountsDrawerHeader(
      accountName: new Text('Location'),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: AssetImage('images/pic1.jpg'), radius: 35.0,),);

    return Scaffold(appBar: AppBar(title: Text("Record Data"),),
      body: new Container(
        color: Colors.white,
        child: Align(alignment: Alignment.center,child:new SingleChildScrollView (
          scrollDirection: Axis.horizontal,
          child:
              new Column(children:datform_list,)
              /*new Row(
              children:<Widget>[
                //CONTENTS
              ]
            )*/

        )),),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            userHeader ,
            ListTile(title: Text('RFID Page'),
              leading: new CircleAvatar(child: new Icon(Icons.school),),
              onTap: () {
                Navigator.of(context).pushNamed('/RFIDPage');
              },),
              ListTile(title: Text('Data Analysis'),
                leading: new CircleAvatar(child: new Icon(Icons.school),),
                onTap: () {
                  //Navigator.of(context).pushNamed('/DataPage');
                },),
            ListTile(title: Text('Manuel Page'),
              leading: new CircleAvatar(child: new Text('B2'),),
              onTap: () {
                //Navigator.pop(context);
                Navigator.of(context).pushNamed('/ManPage');
              },),
            ListTile(title: Text('Settings'),
              leading: new CircleAvatar(
                child: new Icon(Icons.list),),
              onTap: () {
                Navigator.pop(context);
              },),
          ],
        ),
      ),);
  }
}
