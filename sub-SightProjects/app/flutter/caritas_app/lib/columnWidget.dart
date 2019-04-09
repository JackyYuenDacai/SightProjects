import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'RFIDPage.dart';
import 'package:http/http.dart' as http;
class ColForm extends StatefulWidget{
  String name,id,unitok;

  ColForm(
          [String n='Name',
          String i='Id',
        String t='']) : name=n,id=i,unitok=t
          {

          }
  @override
  _ColFormState createState() => new _ColFormState(name,id,unitok);

}

class _ColFormState extends State<ColForm> with SingleTickerProviderStateMixin {
 String name;
 String id;
 String unitok;
 String select0;
 String select1;
 String select2;
  AnimationController _controller;
  Animation<double> _tween;
  int state = 0;  // 0: init
                  // 1: normal
                  // 2: animated
 _ColFormState(this.name,this.id,this.unitok);
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
              new CircleAvatar(child: new Icon(Icons.school),radius: 55.0,),
              new SizedBox(height: 35),
              new Text(widget.name,textAlign:TextAlign.center,style: new TextStyle(
          color: Colors.purple,
          fontSize: 40.0,
        )),
              new SizedBox(height:30),
              new DropdownButton<String>(
                hint: Text("Diaper check"),
                items: <String>['A', 'B', 'C', 'D'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (String value) {select0 = value;},
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
                onChanged: (String value) {select1 = value;},
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
                onChanged: (String value) {select2 = value;},
              ),
              new SizedBox(height:50),
              new RaisedButton(child: const Text('Submit'),
                color: Theme.of(context).accentColor,
                elevation: 4.0,
                splashColor: Colors.blueGrey,
                onPressed:(){
                    //form submitted.
                    if(!RFIDPage.IsNetwork){

                    }else{
                      var url = 'http://localhost:8080/WebInterface/submit_form?';
                      url = url + 'id=' + id +'&';
                      url = url + 'unitok=' + unitok +'&';
                      url = url + 'select0='+select0+'&';
                      url = url + 'select1='+select1+'&';
                      url = url + 'select2='+select2+'&';

                      http.get(url)
                          .then((response) {
                        //print("Response status: ${response.statusCode}");
                        //print("Response body: ${response.body}");
                              if(response.body.length>0)
                                this.dispose();
                            });


                    }

                      _tween = new Tween<double>(begin: 250, end: 0.0).
                          animate(_controller)
                          ..addListener((){
                            setState((){
                                this.dispose();
                            });
                          });
                      startAnimation();
                },),
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
