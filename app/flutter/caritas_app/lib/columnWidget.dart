import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'RFIDPage.dart';
class ColForm extends StatefulWidget{
  @override
  _ColFormState createState() => new _ColFormState();
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
              new RaisedButton(child: const Text('Submit'),
                color: Theme.of(context).accentColor,
                elevation: 4.0,
                splashColor: Colors.blueGrey,
                onPressed:(){
                    //form submitted.
                    if(!RFIDPage.IsNetwork){
                      
                    }
                      _tween = new Tween<double>(begin: 250, end: 0.0).
                          animate(_controller)
                          ..addListener((){
                            setState((){

                            });
                          });
                      startAnimation();
                },)
          ],

        )),
        width: (this?._tween?.value ?? 0.0),
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
