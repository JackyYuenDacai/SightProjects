import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import './enterList.dart';
import './RFIDPage.dart';
import './ManPage.dart';

class CreateSurvey extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CreateSurveyState();
  }
}
class CreateSurveyState extends State<CreateSurvey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Survey')),
    
    );
  }
}
<<<<<<< HEAD
=======

class Question extends StatelessWidget {
   @override
   Widget build(BuildConext context){
   return
      Expanded(
   Text(
   )
   
   }


}
>>>>>>> b829af7c633e1ab90fb166e75fbd3ef8cd9e08e2
