import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:async/async.dart';
import './ManPage.dart';
import 'RFIDPage.dart';
import 'package:http/http.dart' as http;
import 'pop.dart';
class DataForm extends StatefulWidget{
  String name,id;
  ColForm([String n='Name',String i='Id',String t='']) : name=n,id=i,unitok=t
  {

  }
  @override
  _DataFormState createState() => new _DataFormState(name,id,unitok);
}

class _DataFormState extends State<DataForm> with SingleTickerProviderStateMixin {
  String name,id;
  _DataFormState([String n='Name',String i='Id']):name=n,id=i{

  }
void showMyMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text("Dialog"),
            content: new Column(children:<Widget>[]),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
  initState(){
    super.initState();
  }
}
