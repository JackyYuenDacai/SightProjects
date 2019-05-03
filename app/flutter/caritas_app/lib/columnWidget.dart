import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:async/async.dart';
import './ManPage.dart';
import 'RFIDPage.dart';
import 'package:http/http.dart' as http;
import 'pop.dart';
class ColForm extends StatefulWidget{
  String name,id,unitok;
  ColForm([String n='Name',String i='Id',String t='']) : name=n,id=i,unitok=t
  {

  }
  @override
  _ColFormState createState() => new _ColFormState(name,id,unitok);
}

class _ColFormState extends State<ColForm> with SingleTickerProviderStateMixin {
  String name;
  String id;
  String unitok;
  AnimationController _controller;
  Animation<double> _tween;
  var updateStafflist;
  int state = 0;  // 0: init
                  // 1: normal
                  // 2: animated
  _ColFormState(this.name,this.id,this.unitok);
  initState(){
    super.initState();
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
    updateStafflist  = new RestartableTimer(new Duration(seconds:4),(){
       setState((){;});
       updateStafflist.reset();
     });
  }
  _onSubmit(){
    if(!RFIDPage.IsNetwork){
        print('no network');
    }else{
      var url = StaticList.submit_form_api_url;
      url = url + 'id=' + id +'&';
      url = url + 'unitok=' + unitok +'&';
      /*url = url + 'select0=${select0}&' ;
      url = url + 'select1=${select1}&';
      url = url + 'select2=${select2}&';
      url = url + 'select3=${select3}&';*/
      http.get(url)
          .then((response) {
            //print("Submit Response status: ${response.statusCode}");
            print("Submit: ${response.body}");
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
            });
    }
  }

  Map<String,String> answer;
  answerSelected(String title,String value){
    for(question i in StaticList.QuestionList){
      if(i.title == title){
        for(int j = 0; j < i.answer.length;j++){
          if(i.answer[j] == value){
            answer[i.id] = i.answer_id[j];
          }
        }
      }
    }
  }
  Widget build(BuildContext context) {

    return
    new GestureDetector(
      child: new Container(
        width: (this?._tween?.value ?? 0.0), //?. : check if width exist, null-->not initialized, width=0.0, else return width
        height: double.infinity,
        child:Center(child:new SingleChildScrollView (
          scrollDirection: Axis.vertical,
          child: new Center(
            child: new Column(
              children: [
                new SizedBox(height:30),
                new Text(widget.name,textAlign:TextAlign.center,style: new TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  )
                ),
                new Column(children:
                  //question(this.title,this.answer,this.answer_id);
                StaticList.QuestionList.map((question list_val){
                  switch(list_val.type){
                    case null:
                    case 0:
                        return new Column(children:<Widget>[
                          new SizedBox(height:15),
                          new DropdownButton<String>(
                            hint: Container(
                              width:180.0,
                              child:Text(list_val.title)
                            ),
                            //value: select0 == "" ? null : select0 ,
                            items: list_val.answer.map((String value) {
                              return new DropdownMenuItem<String>(
                              value: value,
                              child: Center(child:new Text(value, textAlign: TextAlign.center,style:  TextStyle(
                                                color: Colors.blue,
                                                fontSize: 20.0,
                                              )),
                                            ));
                                          }).toList(),
                              onChanged: (String value) {setState(() {
                                answerSelected(list_val.title,value);
                              });},
                              style:  TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                    )
                                  ),
                                ]
                            );
                            break;
                    case 1:
                            break;
                    case 2:
                        return new Text(
                          list_val.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:24.0,
                          )
                        );
                        break;
                  }

                    }
                  ).toList()
                ),
              new SizedBox(height:15),
              new RaisedButton(child: const Text('Submit',                style:  TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                        )),
                color: Theme.of(context).accentColor,
                elevation: 4.0,
                splashColor: Colors.blueGrey,
                onPressed:(){_onSubmit();},),
              new SizedBox(height:30),
          ],
        )),
      )),
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
  //bool operator ==(o) => o is _ColFormState && o.select0 == select0 ;
  //int get hashCode => select0.hashCode;
}
