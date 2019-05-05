import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:async/async.dart';
import './ManPage.dart';
import 'RFIDPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pop.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:share_extend/share_extend.dart';

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'network_request.dart';

import 'I8N.dart';

import 'RecordChart.dart';
class DataForm extends StatefulWidget{
  String name,id;
  DataForm([String n='Name',String i='Id']) : name=n,id=i
  {

  }
  @override
  _DataFormState createState() => new _DataFormState(name,id);
}

class TimePoint{
  final TimeOfDay time;
  final String when;
  final charts.Color color;
  TimePoint(this.when,this.time,Color color):this.color = new charts.Color(
        r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
class _DataFormState extends State<DataForm> with SingleTickerProviderStateMixin {
  String name,id;
  var chart;
  var chartWidget;
  double _value ;
  http.Response ajaxResponse = new http.Response("",200);
  _DataFormState([String n='Name',String i='Id']):name=n,id=i{

  }
  void refresh(){
    setState((){

    });
  }
  _onDelStudent(){
    if(!RFIDPage.IsNetwork){
        print('no network');
    }else{
      var url = StaticList.del_student_api_url;
      url = url + 'id=' + id +'&';
      http.get(url)
          .then((response) {
            //print("Submit Response status: ${response.statusCode}");
            print("Submit: ${response.body}");
            if(response.body.length>0){

            }
          });
    }
  }
  void deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text("Delete "+name),
            content: new Text('  '),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _onDelStudent();

                  this.setState((){
                    //this.dispose();
                    StaticList.datform_list.remove(this);
                    //Navigator.of(context).pushNamed('/DataPage');
                  });

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
  void getRecordData(String id){
    ajaxResponse = new http.Response("",200);
    var url = StaticList.get_record_export_url+"id="+id+"&time=1980-00-00%2000:00";
    String retCSVdata ="";
    print(url);
    http.get(url)
        .then((response) {
          print("Response body: ${response.body.substring(0)}");
          this.ajaxResponse = (response);
          if(this.ajaxResponse.body.length<=0){
            return;
          }
          shareCSV(response.body);
          //retCSVdata = response.body.substring(0);

    });
    //print(retCSVdata);
    //return retCSVdata;
  }
  void shareCSV(String csvData) async{
    Directory dir = await getApplicationDocumentsDirectory();
    File testFile = new File("${dir.path}/flutter/export.csv");
    if (!await testFile.exists()) {
      await testFile.create(recursive: true);

    }
    testFile.writeAsStringSync(csvData);
    print(csvData);
    ShareExtend.share(testFile.path, "file");
  }
  void getTagsNearby(){
    ajaxResponse = new http.Response("",200);;
    var url = StaticList.get_tags_url+StaticList.location;
    //print(url);
    http.get(url)
        .then((response) {
      //print("Response status: ${response.statusCode}");

          print("Response body: ${response.body}");
          print('get tags list');
          if(response.body.length<=0){
            return;
          }
          tagList tags = new tagList.fromJson(json.decode(response.body));

          StaticList.tag_list.clear();
          for(Tag wid in tags.tags){
              StaticList.tag_list.add(wid.id);
              print('id:'+wid.id);
          }
          //print(StaticList.staff_list);

    });
  }
  //ADD STUDENT VALUE START
  var add_name;
  var add_id;
  var add_extra;
  var add_tagId;
  //ADD STUDENT VALUE END
  void _onModStudent(){
    if(!RFIDPage.IsNetwork){
        print('no network');
    }else{
      var url = StaticList.add_student_api_url;
      url = url + 'id=' + id +'&';
      url = url + 'name=' + add_name +'&';
      url = url + 'extra=${add_extra}&';
      url = url + 'tagId=${add_tagId}&';
      http.get(url)
          .then((response) {
            //print("Submit Response status: ${response.statusCode}");
            print("Submit: ${response.body}");
            if(response.body.length>0){

            }
          });
    }
  }
  void modifyDialog(BuildContext context) {
    add_name = name;
    add_id = id;
    getTagsNearby();
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text("Modify "+name),
            content:
            new Container(
            width:550.0,
            height:500.0,
            child:
            new ListView(
                              children:<Widget>[
                                new Wrap(
                                  direction: Axis.horizontal,
                                  children:
                                    <Widget>[
                                      new Text('Student\'s Name',textAlign:TextAlign.center),
                                      new TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Please enter student\'s name',
                                        ),
                                        onChanged:(text){
                                          add_name = text;
                                        }
                                      ),
                                    ]
                                ),
                                new Wrap(
                                  direction: Axis.horizontal,
                                  children:
                                    <Widget>[
                                      new Text('Extra info',textAlign:TextAlign.center),
                                      new TextField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Please enter student\'s extra info',
                                        ),
                                        onChanged:(text){
                                          add_extra = text;
                                        }
                                      ),
                                    ]
                                ),
                                new DropdownButton<String>(
                                  hint: Container(width:180.0,child:Text("Tags Nearby")),
                                  value: add_tagId == "" ? null : add_tagId ,
                                  items: StaticList.tag_list.map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: Center(child:new Text(value, style:  TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20.0,
                                                      )),
                                    ));
                                  }).toList(),
                                  onChanged: (String value) {setState(() {
                                    add_tagId = value;
                                  });},

                                  style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  )
                                )
                              ]
                            ),),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {

                  Navigator.of(context).pop();
                  _onModStudent();
                },
                child: new Text(I8N.of(context).confirm),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  //add_tagId = null;
                },
                child: new Text(I8N.of(context).cancel),
              ),
            ],
          );
        });
  }
  void recordDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text("Record of "+name),
            content: new DialogContent(name,id),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text(I8N.of(context).confirm),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text(I8N.of(context).cancel),
              ),
            ],
          );
        });
  }
  fetchUserData(BuildContext context){
    recordDialog(context);
  }
  initState(){
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return
      Container(
        width:650.0,
        height:70,
        child:new Slidable(
      delegate: new SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: new Container(
        color: Colors.white,
        child: new ListTile(
          leading: new CircleAvatar(
            backgroundColor: Colors.indigoAccent,
            child: new Text(name.substring(0,1)),
            foregroundColor: Colors.white,
          ),
          title: new Text(name),
          subtitle: new Text(id),
        ),
      ),
      actions: <Widget>[

        new IconSlideAction(
          caption: 'Export',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => getRecordData(id),
        ),
      ],
      secondaryActions: <Widget>[
        new IconSlideAction(
          caption: 'Records',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => fetchUserData(context),
        ),
        new IconSlideAction(
          caption: 'Modify',
          color: Colors.blue,
          icon: Icons.mode_edit,
          onTap: () => modifyDialog(context),
        ),
        new IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => deleteDialog(context),
        ),
      ],
    ));
  }
}
