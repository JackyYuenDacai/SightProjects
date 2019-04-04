import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import './enterList.dart';
import './RFIDPage.dart';
import './ManPage.dart';

class CreateSurvey extends StatefulWidget {
  String name;
  String question;
  CreateSurvey(String question){
    this.question = question;
  }

  @override
  State<StatefulWidget> createState() {
    return new CreateSurveyState();
  }
}
class CreateSurveyState extends State<CreateSurvey> {
  String answer;
  surveyAnswer(String answer){
    this.answer = answer;
  }
  get name => null;
  final List questionList = ['Who are you?','How old are you?','Where will you go?'];
  final List answerList = ['A','B','C','D'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: name,),
        body: Row(
          children: [
            Survey.question(questionList[0]),
            Row(children: answerList.map((element) => Survey.answer(element)).toList())
          ]
        ),
    );
  }
}
class Survey extends StatelessWidget {
  String q;
  Survey.question(String q){
    this.q = q;
  }
  String a;
  Survey.answer(String a){
    this.a = a;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(a)
    );
  }
}