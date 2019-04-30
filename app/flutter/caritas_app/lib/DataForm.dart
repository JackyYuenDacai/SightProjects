import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:async/async.dart';
import './ManPage.dart';
import 'RFIDPage.dart';
import 'package:http/http.dart' as http;
import 'pop.dart';

class DataForm extends StatefulWidget{
  String name,id;
  DataForm([String n='Name',String i='Id']) : name=n,id=i
  {

  }
  @override
  _DataFormState createState() => new _DataFormState(name,id);
}

class _DataFormState extends State<DataForm> with SingleTickerProviderStateMixin {
  String name,id;
  http.Response ajaxResponse = new http.Response("",200);
  _DataFormState([String n='Name',String i='Id']):name=n,id=i{

  }
  void showMyMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text("Dialog"),
            content: new Column(children:<Widget>[]),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Confirm"),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Cancel"),
              ),
            ],
          );
        });
  }
  fetchUserData(BuildContext context){
    ajaxResponse = new http.Response("",200);;
    var url = StaticList.get_record_data_url+"id="+id+"&time="+"1980-00-00 00:00:00";
    //print(url);
    http.get(url)
        .then((response) {
      //print("Response status: ${response.statusCode}");

          print("Response body: ${response.body}");
          print('get record data');
          if(response.body.length<=0){
            return;
          }
          //studentList staffs = new studentList.fromJson(json.decode(response.body));
          //StaticList.student_id.clear();
          //StaticList.student_name.clear();
          //for(student wid in staffs.Staffs){
          //  this.setState((){
              //StaticList.student_id.add(wid.id);
              //print('name:'+wid.name);
              //StaticList.student_name.add(wid.name);
              //datform_list.add(new DataForm(wid.name,wid.id));
          //  });

          //}

          //ajaxCall.reset();
    });
    showMyMaterialDialog(context);
  }
  initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return (new Row(
              children: <Widget>[
                new SizedBox(width:15.0),
                new Container(
                  width:350.0,
                  child:
                new Text(name,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 32.0,color: Colors.blue),
                  )
                )
                ,
                new SizedBox(width:15.0),
                new RaisedButton(
                  onPressed: (){
                      fetchUserData(context);
                  },
                  textColor: Colors.white,
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "View",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 32.0,color: Colors.blue),
                  ),
                  )
              ]
            )

    );
  }
}
