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

class RFIDPage extends StatefulWidget {
  static var IsNetwork = true;
  @override
  State<StatefulWidget> createState() {
    return new _RFIDPageState();
  }
}

class _RFIDPageState extends State<RFIDPage> {
  Duration ajaxCallDuration = new Duration(seconds:2);
  var ajaxCall = null;
  http.Response ajaxResponse = new http.Response("",200);
  addColForm(String name,String id,String unitok){
    this.setState((){
      colform_list.add(new ColForm(name,id,unitok));
    });
  }
  delColForm(Object obj){
    this.setState((){
      colform_list.remove(obj);
    });
  }
  ajaxCallFun(){
    var url = 'http://localhost:8080/WebInterface/get_pops_list?location='+'A';
    http.get(url)
        .then((response) {
      //print("Response status: ${response.statusCode}");
      //print("Response body: ${response.body}");
      this.ajaxResponse = response;
          });
    print("Response body:${ajaxResponse.body}");
    if(ajaxResponse.body.length <= 0){
      ajaxCall.reset();
      return;
    }
    popList pops = new popList.fromJson(json.decode(ajaxResponse.body));

    for(pop wid in pops.Pops){
      //print("one pop ${wid.name} ${wid.id}");

        if(wid.status == "0"){
            this.addColForm(wid.name,wid.id,wid.unitok);

          //  colform_list.add(new ColForm());
            print("added colform ${wid.name} ${wid.id} ${wid.unitok}");


        }else if(wid.status == "1"){
          for(var a in colform_list){
            if(a.name == wid.name){
              this.delColForm(a);
              print("deleted colform ${wid.name} ${wid.id} ${wid.unitok}");

              break;
              //colform_list.remove(a);
            }
          }
        }
    }
    ajaxCall.reset();
  }
  var subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async{
        var connectivityResult = await Connectivity().checkConnectivity();
        if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
              //DUMMY
        }else{
            //DUMMY
        }
      });
  var colform_list = new List<ColForm>();
  initState(){
    super.initState();
    ajaxCall = new RestartableTimer(ajaxCallDuration,ajaxCallFun);

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
          child: new Row(children:colform_list,)
        ),),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            userHeader ,
            ListTile(title: Text('RFID Page'),
              leading: new CircleAvatar(child: new Icon(Icons.school),),
              onTap: () {
                //Navigator.of(context).pushNamed('/RFIDPage');
              },),
            ListTile(title: Text('Manuel Page'),
              leading: new CircleAvatar(child: new Text('B2'),),
              onTap: () {
                //Navigator.pop(context);
                this.dispose();
                Navigator.of(context).pushNamed('/ManPage');
              },),
            ListTile(title: Text('Settings'),
              leading: new CircleAvatar(
                child: new Icon(Icons.list),),
              onTap: () {
                Navigator.pop(context);
              },),
              ListTile(title: Text('+'),
                leading: new CircleAvatar(
                  child: new Icon(Icons.list),),
                onTap: () {
                  this.setState((){
                    colform_list.add(new ColForm('Test','001'));
                  });
                },),
          ],
        ),
      ),);
  }
  dispose(){

    ajaxCall=null;
    subscription.cancel();
    super.dispose();
  }
}
