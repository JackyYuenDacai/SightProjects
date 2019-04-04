import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import './enterList.dart';
import './RFIDPage.dart';
import './ManPage.dart';

class CreateSurvey extends StatefulWidget {
  String question;
  String name;
  CreateSurvey(String name) {
    this.name = name;
  }

  @override
  State<StatefulWidget> createState() {
    return new CreateSurveyState(name);
  }
}

class CreateSurveyState extends State<CreateSurvey> {
  final List questionList = [
    'Who are you?',
    'How old are you?',
    'Where will you go?'
  ];
  final List answerList = ['A', 'B', 'C', 'D'];
  String name;
  CreateSurveyState(String name) {
    this.name = name;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Row(children: <Widget>[
        SurveyQuestion(questionList[0]),
        Row(
            children:
                answerList.map((element) => SurveyAnswer(element)).toList())
      ]),
    );
  }
}
//Below need to modify in order to have better look
class SurveyQuestion extends StatelessWidget {
  String q;
  SurveyQuestion(String q) {
    this.q = q;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(children: [Expanded(child: Text(q))]));
  }
}

class SurveyAnswer extends StatelessWidget {
  String a;
  SurveyAnswer(String a) {
    this.a = a;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(children: [Expanded(child: Text(a))]));
  }
}
