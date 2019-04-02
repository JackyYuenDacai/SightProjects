import 'package:flutter/material.dart';
import 'RFIDPage.dart';
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
  String Name;
  AnimationController _controller;
  Animation<double> _tween;
  int state = 0;  // 0: init
                  // 1: normal
                  // 2: animated

  initState(){

    super.initState();
    //print('init Called');
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 600),
      vsync:this,);
    _tween = new Tween<double>(begin: 0.0, end: 250).
            animate(_controller)
            ..addListener(() {
              setState(() {
                //print(tween.value);
            });
      });
     _controller.forward(from: 0.0);
  }
  Widget build(BuildContext context) {
    return new GestureDetector( 
      child: new Container(
        child: new Center(
          child: new Column(
            children: [
              new SizedBox(height: 75),
              new CircleAvatar(child: new Icon(Icons.school),radius: 35.0,),
              new SizedBox(height: 35),
              new Text('Name',textAlign:TextAlign.center),
              new SizedBox(height:50),
            ],

        )),
        width: (this?._tween?.value ?? 0.0), //?. : check if width exist, null-->not initialized, width=0.0, else return width 
        height: double.infinity,
        decoration: new BoxDecoration(
          color: Colors.lightBlue[400]
        ),
      ),
    );
  }
  startAnimation(){
    setState((){
      _controller.forward(from: 0.0);
    });
  }
  dispose(){
    _controller.dispose();
    super.dispose();
  }
}
