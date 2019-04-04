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
  get name => null;
  final List questionList = ['Who are you?','How old are you?','Where will you go?'];
  final List answerList = ['A','B','C','D'];
  @override
  Widget build(BuildContext context) {
    Widget surveyQuestion =(
      Container(
        
      )

    );
    Widget surveyAnswer =(
      Container(

      )

    );
    return Scaffold(
        appBar: AppBar(title: name,),
        body: Column(
          children: <Widget> [
            surveyQuestion,
            surveyAnswer
          ]
        ),
    );
  }
}
