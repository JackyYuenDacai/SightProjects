import 'package:flutter/material.dart';
class ColForm extends StatefulWidget{
  @override
  _ColFormState createState() => new _ColFormState();
  setName(String name){

  }
  setId(String id){

  }
}

class _ColFormState extends State<ColForm> with SingleTickerProviderStateMixin {
  int id;
  String name;
  int state = 0;  // 0: init
                  // 1: normal
                  // 2: animated

  }
  initState(){
  super.initState();
  Widget build(BuildContext context) {
    return new GestureDetector( 
      child: new Container(
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
      ),
    );
  }
}

}