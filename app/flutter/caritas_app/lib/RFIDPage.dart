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
import 'package:flutter_localizations/flutter_localizations.dart';
import './I8N.dart';
import 'network_request.dart';
class RFIDPage extends StatefulWidget {
  static var IsNetwork = true;
  @override
  State<StatefulWidget> createState() {
    return new _RFIDPageState();
  }
}

class _RFIDPageState extends State<RFIDPage> {
  Duration ajaxCallDuration = new Duration(seconds:6);
  var ajaxCall = null;
  http.Response ajaxResponse = new http.Response("",200);
  var subscription;

  ajaxCallFun(){

    try{
      this.setState((){
        network_request.get_pop_list(StaticList.location);
        network_request.get_staff_list(StaticList.location);
      });
      ajaxCall.reset();
    }catch(e){
      print(e.toString());
    }
  }
  initState(){
    super.initState();
    ajaxCall = new RestartableTimer(ajaxCallDuration,ajaxCallFun);
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async{
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
      accountName: new Text('Location '+StaticList.location),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: AssetImage('images/pic1.jpg'), radius: 35.0,),);

    return
    new WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
          appBar: AppBar(title: Text(I8N.of(context).rfid_title),),
          body: new Container(
            child: new SingleChildScrollView (
              scrollDirection: Axis.horizontal,
              child: new Row(children:StaticList.colform_list,)
            ),),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                userHeader ,
                ListTile(title: Text(I8N.of(context).rfid_title),
                  leading: new CircleAvatar(child: new Icon(Icons.school),),
                  onTap: () {
                    //Navigator.of(context).pushNamed('/RFIDPage');
                  },),
                ListTile(title: Text(I8N.of(context).students_title),
                  leading: new CircleAvatar(child: new Icon(Icons.school),),
                  onTap: () {
                    Navigator.of(context).pushNamed('/DataPage');
                  },),
                ListTile(title: Text(I8N.of(context).manuel_title),
                  leading: new CircleAvatar(child: new Text('B2'),),
                  onTap: () {
                    //Navigator.pop(context);
                    //this.dispose();
                    Navigator.of(context).pushNamed('/ManPage');
                  },),
                ListTile(title: Text(I8N.of(context).setting_title),
                  leading: new CircleAvatar(
                    child: new Icon(Icons.list),),
                  onTap: () {
                                    Navigator.of(context).pushNamed('/SettingPage');
                  },),
              ],
            ),
          ),)
    );
  }
  dispose(){

    ajaxCall=null;
    subscription.cancel();
    super.dispose();
  }
}
