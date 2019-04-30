import 'package:flutter/material.dart';
import './columnWidget.dart';
import './RFIDPage.dart';
import './ManPage.dart';
import './pop.dart';
class DataPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _DataPageState();
  }
}

class _DataPageState extends State<DataPage> {
  initState(){
    super.initState();
    ajaxResponse = new http.Response("",200);;
    url = StaticList.get_student_list;
    //print(url);
    http.get(url)
        .then((response) {
      //print("Response status: ${response.statusCode}");

          print("Response body: ${response.body}");
          print('get student list');
          if(response.body.length<=0){
            ajaxCall.reset();
          }
          studentList staffs = new studentList.fromJson(json.decode(response.body));
          StaticList.student_id.clear();
          StaticList.student_list.clear();
          for(student wid in staffs.Staffs){
            this.setState((){
              StaticList.student_id.add(wid.id);
              print('name:'+wid.name);
              StaticList.student_list.add(wid.name);
            });
          }
          print(StaticList.staff_list);
          ajaxCall.reset();
    });
    //print("Response body:${ajaxResponse.body}");
    if(this.ajaxResponse.body.length <= 0){
      ajaxCall.reset();
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget userHeader = UserAccountsDrawerHeader(
      accountName: new Text('Location'),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: AssetImage('images/pic1.jpg'), radius: 35.0,),);

    return Scaffold(appBar: AppBar(title: Text("Home"),),
      body: new Container(
        child: Align(alignment: Alignment.center,child:new SingleChildScrollView (
          scrollDirection: Axis.horizontal,
          child: new Align(
            alignment: Alignment.center,
            child:new Row(
              children:[
                //CONTENTS
              ]
          ))
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
