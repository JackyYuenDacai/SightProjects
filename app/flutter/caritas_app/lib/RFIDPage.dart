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
    return new Container(
        child: Center(
            child: Column(children: [
           SizedBox(height: 75),
           CircleAvatar(
            child:  Icon(Icons.school),
            radius: 70.0,
          ),
           SizedBox(height: 35),
           Text(
            name,
            textAlign: TextAlign.center,
            textScaleFactor: 2.0,
          ),
           SizedBox(height: 50),
        ])),
        width:
            (0.0), //?. : check if width exist, null-->not initialized, width=0.0, else return width
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.lightBlue[200]),
        /*onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateSurvey()),
          );
        }*/);
  }
}
