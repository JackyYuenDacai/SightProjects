import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import './enterList.dart';
import './survey.dart';

class Frame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _FrameState();
  }
}

class _FrameState extends State<Frame> {

  final List colformList = ['Mickey','Jacky','Don'];
  @override


    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Toilet iPad"),
      ), //replace with toilet location?
      body: new Container(
          child: new SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: new Row(children: colformList.map((element) => ColEntry(element)).toList()
                  //children:colform_list,
                  ))),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text('Location'),
              currentAccountPicture: new CircleAvatar(
                  backgroundImage: AssetImage('images/pic1.jpg'), radius: 35.0),
              accountEmail: null,
            ),
            ListTile(
              title: Text('Manuel Page'),
              leading: new CircleAvatar(
                child: new Text('B2'),
              ),
              onTap: () {
                //Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Settings'),
              leading: new CircleAvatar(
                child: new Icon(Icons.list),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
                title: Text('+ Test Student'),
                leading: new CircleAvatar(
                  child: new Icon(Icons.list),
                ),
                onTap: () {
                  this.setState((){
                  colformList.add('Test');
                  });
                })
          ],
        ),
      ),
    );
  }
}
class ColEntry extends StatelessWidget {
  String name;
  ColEntry(String name){
    this.name = name;
  }
  @override
  Widget build(BuildContext context) {
    return Container(child: FlatButton(
        child: Center(
            child: Column(children: [
              Expanded(child: SizedBox(),),
           CircleAvatar(
            child:  Icon(Icons.school),
            radius: 100.0,
          ),
           SizedBox(height: 35),
           Text(
            name,
            textAlign: TextAlign.center,
            textScaleFactor: 2.0,
          ),
          Expanded(child: SizedBox(),),
        ])),

        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateSurvey(name)),
          );
        }));
  }
}
