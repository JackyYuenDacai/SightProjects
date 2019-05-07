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
import 'package:flutter_localizations/flutter_localizations.dart';
import './I8N.dart';
import 'network_request.dart';
class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SettingPageState();
  }
}

class _SettingPageState extends State<SettingPage> {
  http.Response ajaxResponse = new http.Response("",200);

  initState(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Widget userHeader = UserAccountsDrawerHeader(
      accountName: new Text('Location'),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: AssetImage('images/pic1.jpg'), radius: 35.0,),);

    return new WillPopScope(
  onWillPop: () async {
    return true;
  },
  child: Scaffold(
      appBar: AppBar(title: Text("Setting"),),
      body:
      new Container(
          margin: const EdgeInsets.only(top:40.0, left: 20.0, right: 20.0),
          child:  ListView(
                        children: <Widget>[
                          new RaisedButton(child: Text('Add Staff',
                          style:  TextStyle(
                                      color: Colors.white,
                                      fontSize: 40.0,
                                    )),
                            color: Theme.of(context).accentColor,
                            elevation: 4.0,
                            splashColor: Colors.blueGrey,
                            onPressed:(){AddStudentDialog(context);},),
                        ]

                      ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            userHeader ,
            ListTile(title: Text(I8N.of(context).rfid_title),
              leading: new CircleAvatar(child: new Icon(Icons.school),),
              onTap: () {
                Navigator.of(context).pushNamed('/RFIDPage');
              },),
            ListTile(title: Text(I8N.of(context).students_title),
              leading: new CircleAvatar(child: new Icon(Icons.school),),
              onTap: () {
                Navigator.of(context).pushNamed('/DataPage');
              },),
            ListTile(title: Text(I8N.of(context).manuel_title),
              leading: new CircleAvatar(child: new Text('B2'),),
              onTap: () {
                Navigator.of(context).pushNamed('/ManPage');
              },),
            ListTile(title: Text(I8N.of(context).setting_title),
              leading: new CircleAvatar(
                child: new Icon(Icons.list),),
              onTap: () {

              },),

          ],
        ),
      ),));
  }
  //ADD STUDENT VALUE START
  var add_name;
  var add_id;
  var add_extra;
  var add_tagId;
  //ADD STUDENT VALUE END
  _onAddStudent(){

      var url = StaticList.add_staff_api_url;
      url = url + 'id=' + add_id +'&';
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
              //print('id:'+wid.id);
          }
          //print(StaticList.staff_list);

    });
  }

  void AddStudentDialog(BuildContext context) {
    getTagsNearby();
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text(I8N.of(context).add_staff),
            content: new Container(
              width:450.0,

              child:
                new ListView(
                  children:<Widget>[
                    new Wrap(
                      direction: Axis.horizontal,
                      children:
                        <Widget>[
                          new Text('Staff\'s Name',textAlign:TextAlign.center),
                          new TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Please enter staff\'s name',
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
                          new Text('Student\'s ID',textAlign:TextAlign.center),
                          new TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Please enter staff\'s id',
                            ),
                            onChanged:(text){
                              add_id = text;
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
                      onChanged: (String value) {setState(() {add_tagId = value;});},
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )
                    )
                  ]
                )
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  //ADD STUDENT
                  _onAddStudent();
                  Navigator.of(context).pop();
                  add_tagId = null;
                },
                child: new Text(I8N.of(context).confirm),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  add_tagId = null;
                },
                child: new Text(I8N.of(context).cancel),
              ),
            ],
          );
        });
  }
  dispose(){
    super.dispose();
  }
}
