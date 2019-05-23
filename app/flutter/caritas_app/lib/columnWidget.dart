import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:async/async.dart';
import './ManPage.dart';
import 'RFIDPage.dart';
import 'package:http/http.dart' as http;
import 'pop.dart';
import 'network_request.dart';
import './I8N.dart';
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

      network_request.post_submit_form(id,unitok,answer);
      
      setState((){});
    }
  }

  Map<String,String> answer = new Map<String,String>();
  answerSelected(String title,String value){
    //print(title);
    //print(value);
    for(question i in StaticList.QuestionList){
      if(i.title == title){
        for(int j = 0; j < i.answer.length;j++){
          if(i.answer[j] == value){
            answer[i.id] = i.answer_id[j];
            print(i.answer_id[j]);
          }
        }
      }
    }
  }
  String answerValue(String title){
    for(question i in StaticList.QuestionList){
      if(i.title == title){
        //print(i.id);
        for(int j = 0; j < i.answer.length;j++){
          if(i.answer_id[j] == answer[i.id]){
            return i.answer[j];
          }
        }
      }
    }
    return null;
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
                new SizedBox(height:10),
                new DropdownButton<String>(
                  hint: Container(width:180.0,child:Text("Staff Responsible")),
                  value: answer['staff'] ?? null ,
                  items: StaticList.staff_list.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: Center(child:new Text(value, style:  TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                      )),
                    ));
                  }).toList(),
                  onChanged: (String value) {setState(() {
                    answer['staff'] = value;
                  });},

                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  )
                ),
                new Column(children:
                  //question(this.title,this.answer,this.answer_id);
                StaticList.QuestionList.map((question list_val){
                  switch(list_val.type){
                    case null:
                    case 0:
                        return new Column(children:<Widget>[
                          new SizedBox(height:5),
                          new DropdownButton<String>(
                            hint: Container(
                              width:180.0,
                              child:Text(list_val.title)
                            ),
                            value: answerValue(list_val.title) ?? null,
                            items: list_val.answer.map((String value) {
                              return new DropdownMenuItem<String>(
                              value: value,
                              child: Center(child:new Text(value, textAlign: TextAlign.center,style:  TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                              )),
                                            ));
                                          }).toList(),
                              onChanged: (String value_clicked) {
                                setState(() {
                                    answerSelected(list_val.title,value_clicked);
                                  }
                                );
                              },
                              style:  TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                    )
                                  ),
                                ]
                            );
                            break;
                    case 1:
                        return new Column(
                              children: <Widget>[
                                new CheckboxListTile(
                                  title: new Text(list_val.title,
                                    style: TextStyle(
                                      color:Colors.white,
                                      fontSize:17.0,
                                    )
                                  ),
                                  controlAffinity: ListTileControlAffinity.leading,
                                  activeColor: Colors.green,
                                  value: (((answerValue(list_val.title)) == 'true')? true:false) ,
                                  onChanged: (bool value) {
                                    setState((){
                                      if(answerValue(list_val.title) == 'true'){
                                        answerSelected(list_val.title,'false');
                                      }else{
                                        answerSelected(list_val.title,'true');
                                      }

                                    });
                                    print(answer);

                                  },
                                ),

                              ],
                        );
                        break;
                    case 2:
                        return new Text(
                          list_val.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:20.0,
                          )
                        );
                        break;
                  }

                    }
                  ).toList()
                ),
              new SizedBox(height:10),
              new RaisedButton(child: Text(I8N.of(context).submit_text,
              style:  TextStyle(
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
    updateStafflist.cancel();
    super.dispose();
  }
  //bool operator ==(o) => o is _ColFormState && o.select0 == select0 ;
  //int get hashCode => select0.hashCode;
}
