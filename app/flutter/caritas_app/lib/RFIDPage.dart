import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import './enterList.dart';
import './ManPage.dart';

class RFIDPage extends StatefulWidget {
  static var networkConnection = true;
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
  var colform_list = [new ColForm(),new ColForm()];
  initState(){
    super.initState();
    var subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async{
          var connectivityResult = await Connectivity().checkConnectivity();
          if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
            //NO NETWORK CONNECTION
            RFIDPage.networkConnection = false;
          }else{
            //HAVE NETWORK CONNECTION
            RFIDPage.networkConnection = true;
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
      appBar: AppBar(title: Text("Toilet iPad"),), //replace with toilet location?
      body: new Container(
        child: new SingleChildScrollView (
          scrollDirection: Axis.horizontal,
          child: new Row(
            children:colform_list,
          )
        ),),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            userHeader ,
            ListTile(title: Text('Toilet iPad'), //replace with toilet location?
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
              ListTile(title: Text('+ Test Student'),
                leading: new CircleAvatar(
                  child: new Icon(Icons.list),),
                onTap: () {
                  this.setState((){
                    colform_list.add(new ColForm());
                  });
                },),
          ],
        ),
      ),);
  }
  dispose(){
    subscription.cancel();
  }
}
class ColEntry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return       
     new Container(
        child: new Center(
          child: new Column(
            children: [
              new SizedBox(height: 75),
              new CircleAvatar(child: new Icon(Icons.school),radius: 70.0,),
              new SizedBox(height: 35),
              new Text(
                name,
                textAlign:TextAlign.center, 
                textScaleFactor:2.0,
              ),
              new SizedBox(height:50),
            ]
        )),
        width: (0.0), //?. : check if width exist, null-->not initialized, width=0.0, else return width 
        height: double.infinity,
        decoration: new BoxDecoration(
          color: Colors.lightBlue[200]
        ),
      );
  }

  
}