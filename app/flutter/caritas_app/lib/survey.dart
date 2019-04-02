import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import './columnWidget.dart';
import './RFIDPage.dart';
import './ManPage.dart';
   



    new DropdownButton<String>(
      hint: Text("Diaper check"),
      items: <String>['A', 'B', 'C', 'D'].map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (_) {},
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
      onChanged: (_) {},
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
      onChanged: (_) {},
    ),
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
      },),