import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import './columnWidget.dart';
import './RFIDPage.dart';
import './ManPage.dart';

class RFIDPage extends StatefulWidget {
  static var IsNetwork = true;
  @override
  State<StatefulWidget> createState() {
    return new _RFIDPageState();
  }
}

class _RFIDPageState extends State<RFIDPage> {

  var subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async{
        var connectivityResult = await Connectivity().checkConnectivity();
        if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
              //DUMMY
        }else{
            //DUMMY
        }
      });
  initState(){
    super.initState();
    var subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async{
          var connectivityResult = await Connectivity().checkConnectivity();
          if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
            //NO NETWORK CONNECTION
            RFIDPage.IsNetwork = false;
          }else{
            //HAVE NETWORK CONNECTION
            RFIDPage.IsNetwork = true;
          }
        });
  }
  @override
  Widget build(BuildContext context) {
    Widget userHeader = UserAccountsDrawerHeader(
      accountName: new Text('Location'),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: AssetImage('images/pic1.jpg'), radius: 35.0,),);

    return Scaffold(
      appBar: AppBar(title: Text("RFID Page"),),
      body: new Container(
        child: new SingleChildScrollView (
          scrollDirection: Axis.horizontal,
          child: new Row(
            children:[
              new ColForm(),
              new ColForm(),
            ]
          )
        ),),
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
  dispose(){
    subscription.cancel();
  }
}