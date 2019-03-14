import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:async';

class ManPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ManPageState();
  }
}

class _ManPageState extends State<ManPage> {

  var subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async{
        var connectivityResult = await Connectivity().checkConnectivity();
        if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
          //NO NETWORK CONNECTION
        }
    });
  initState(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    Widget userHeader = UserAccountsDrawerHeader(
      accountName: new Text('Location'),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: AssetImage('images/pic1.jpg'), radius: 35.0,),);

    return Scaffold(
      appBar: AppBar(title: Text("Manual Page"),),

      body:
      new Container(
          margin: const EdgeInsets.only(top:40.0, left: 20.0, right: 20.0),
          child:  ListView(

                        children: <Widget>[
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
                                ),
                              ]
                          ),
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
                                ),
                              ]
                          ),
                          new Wrap(
                            direction: Axis.horizontal,
                            children:
                            <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                          DatePicker.showDatePicker(context,
                                                showTitleActions: true,
                                                minTime: DateTime(2018, 3, 5),
                                                maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                                              print('change $date');
                                            }, onConfirm: (date) {
                                              print('confirm $date');
                                            }, currentTime: DateTime.now(), locale: LocaleType.zh);
                                      },
                                      child: Text(
                                          'pick the time student got in',
                                          style: TextStyle(color: Colors.blue),
                                      )),
                                  FlatButton(
                                    onPressed: () {
                                        DatePicker.showDatePicker(context,
                                                              showTitleActions: true,
                                                              minTime: DateTime(2018, 3, 5),
                                                              maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                                                            print('change $date');
                                                          }, onConfirm: (date) {
                                                            print('confirm $date');
                                                          }, currentTime: DateTime.now(), locale: LocaleType.zh);
                                    },
                                    child: Text(
                                        'pick the time student got out',
                                        style: TextStyle(color: Colors.blue),
                                    )),
                            ]
                          ),

                              new DropdownButton<String>(
                                hint: Text("Diaper check"),
                                items: <String>['A', 'B', 'C', 'D'].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                              new SizedBox(height:50),
                              new DropdownButton<String>(
                                hint: Text("Wet diaper"),
                                items: <String>['A', 'B', 'C', 'D'].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),
                              new SizedBox(height:50),
                              new DropdownButton<String>(
                                hint: Text("Toileting condition"),
                                items: <String>['A', 'B', 'C', 'D'].map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (_) {},
                              ),]

                      ),
      ),
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
