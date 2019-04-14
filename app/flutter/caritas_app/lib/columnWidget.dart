import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'RFIDPage.dart';
import 'package:http/http.dart' as http;
import 'pop.dart';
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
 String select0 = 'A';
 String select1 = 'A';
 String select2 = 'A';
 String select3 = 'A';
  AnimationController _controller;
  Animation<double> _tween;
  int state = 0;  // 0: init
                  // 1: normal
                  // 2: animated
 _ColFormState(this.name,this.id,this.unitok);
  initState(){

    super.initState();
    //print('init Called');
    //select0 = "0";
    //select1 = "1";
    //select2 = "2";
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 600),
      vsync:this,);
    _tween = new Tween<double>(begin: 0.0, end: 250).
            animate(_controller)
            ..addListener(() {
              setState(() {

            });
      });
     _controller.forward(from: 0.0);
  }
  _onSubmit(){
    if(!RFIDPage.IsNetwork){
        print('no network');
    }else{
      var url = StaticList.submit_form_api_url;
      url = url + 'id=' + id +'&';
      url = url + 'unitok=' + unitok +'&';
      url = url + 'select0=${select0}&' ;
      url = url + 'select1=${select1}&';
      url = url + 'select2=${select2}&';

      http.get(url)
          .then((response) {
        print("Submit Response status: ${response.statusCode}");
        print("Submit Response body: ${response.body}");
              if(response.body.length>0)
              _tween = new Tween<double>(begin: 250, end: 0.0).
                  animate(_controller)
                  ..addListener((){
                    setState((){ });
                  })
                  ..addStatusListener((AnimationStatus status) {
                  if (status == AnimationStatus.completed){
                    this.dispose();
                    StaticList.colform_list.remove(this);

                  }
                });
                _controller.forward(from:250.0);
              //_controller.forward(from: 250.0);
            });


    }


  }
  Widget build(BuildContext context) {
    if(select0 == null){
      select0 = 'A';
    }
    if(select1 == null){
      select1 = 'A';
    }
    if(select2 == null){
      select2 = 'A';
    }
    return new GestureDetector(
      child: new Container(
        child: new Center(
          child: new Column(
            children: [
              new SizedBox(height: 75),
              new CircleAvatar(child: new Icon(Icons.school),radius: 55.0,),
              new SizedBox(height: 35),
              new Text(widget.name,textAlign:TextAlign.center,style: new TextStyle(
          color: Colors.white,
          fontSize: 40.0,
        )),
              new SizedBox(height:30),
              new DropdownButton<String>(
                hint: Text("Diaper check"),
                //value: (this?.select0 ?? "A"),
                items: <String>['A', 'B', 'C', 'D'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value, style:  TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                    )),
                  );
                }).toList(),
                onChanged: (String value) {setState(() {select0 = value;});},
                      style:  TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                )
              ),
              new SizedBox(height:10),
              new DropdownButton<String>(
                hint: Text("Wet diaper"),
                //value: (this?.select1 ?? "A"),
                items: <String>['A', 'B', 'C', 'D'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value, style:  TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                    )),
                  );
                }).toList(),
                onChanged: (String value) {setState(() {select1 = value;});},
                style: new TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          )
              ),
              new SizedBox(height:10),
              new DropdownButton<String>(
                hint: Text("Toileting condition"),
                //value: (this?.select2 ?? "A"),
                items: <String>['A', 'B', 'C', 'D'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value, style:  TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                    )),
                  );
                }).toList(),
                onChanged: (String value) {setState(() {select2 = value;});},
                style: new TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          )
              ),
              new SizedBox(height:10),
              new DropdownButton<String>(
                hint: Text("Staff Responsible"),
                //value: (this?.select2 ?? "A"),
                items: StaticList.staff_list.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value, style:  TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                    )),
                  );
                }).toList(),
                onChanged: (String value) {setState(() {select3 = value;});},

                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                )
              ),
              new SizedBox(height:30),
              new RaisedButton(child: const Text('Submit',                style:  TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                        )),
                color: Theme.of(context).accentColor,
                elevation: 4.0,
                splashColor: Colors.blueGrey,
                onPressed:(){_onSubmit();},),

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
  bool operator ==(o) => o is _ColFormState && o.select0 == select0 ;
  int get hashCode => select0.hashCode;
}
