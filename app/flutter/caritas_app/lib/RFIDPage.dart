import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import './enterList.dart';
import './survey.dart';

class Frame extends StatelessWidget {
  final List colformList = [new ColForm(), new ColForm()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Toilet iPad"),
      ), //replace with toilet location?
      body: new Container(
          child: new SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: new Row(children: colformList.map((element) => ColEntry())
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
                  colformList.add(new ColForm());
                })
          ],
        ),
      ),
    );
  }
}

class RFIDPage extends StatefulWidget {
  static var networkConnection = true;
  @override
  State<StatefulWidget> createState() {
    return new _RFIDPageState();
  }
}

class _RFIDPageState extends State<RFIDPage> {
  var subscription = Connectivity()
      .onConnectivityChanged
      .listen((ConnectivityResult result) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      //DUMMY
    } else {
      //DUMMY
    }
  });
  initState() {
    super.initState();
    var subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult != ConnectivityResult.mobile &&
          connectivityResult != ConnectivityResult.wifi) {
        //NO NETWORK CONNECTION
        RFIDPage.networkConnection = false;
      } else {
        //HAVE NETWORK CONNECTION
        RFIDPage.networkConnection = true;
      }
    });
  }

  @override
  dispose() {
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class ColEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new Center(
            child: new Column(children: [
          new SizedBox(height: 75),
          new CircleAvatar(
            child: new Icon(Icons.school),
            radius: 70.0,
          ),
          new SizedBox(height: 35),
          new Text(
            element,
            textAlign: TextAlign.center,
            textScaleFactor: 2.0,
          ),
          new SizedBox(height: 50),
        ])),
        width:
            (0.0), //?. : check if width exist, null-->not initialized, width=0.0, else return width
        height: double.infinity,
        decoration: new BoxDecoration(color: Colors.lightBlue[200]),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateSurvey()),
          );
        });
  }
}
