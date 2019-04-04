import 'package:flutter/material.dart';

import './enterList.dart';
import './RFIDPage.dart';
import './ManPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
  routes: {
    '/first': (context) => ManPage(),
    '/second': (context) => Frame(),
  },
        home: Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: Menu()
      
      //decoration: new BoxDecoration(color: Colors.lightBlue[200]),
    ));
  }
}
class Menu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return 
      Row(children: <Widget>[
        Container(
          height: double.infinity,
          alignment: Alignment.center,
            child: FlatButton(
              child: Column(
              children: <Widget>[
                CircleAvatar(child: Icon(Icons.school), radius: 60.0),
                SizedBox(height: 35),
                Text(
                    'Staff',
                    textAlign: TextAlign.center,
                    textScaleFactor: 3.0,
                ), 
              ]
            ),
          onPressed: () {
            // Navigate to the second screen using a named route
            Navigator.pushNamed(context, '/first');
          })),
        Container(
          height: double.infinity,
          alignment: Alignment.center,
            child: FlatButton(
              child: Column(
              children: <Widget>[
                CircleAvatar(child: Icon(Icons.school), radius: 60.0),
                SizedBox(height: 35),
                Text(
                    'Toilet iPad',
                    textAlign: TextAlign.center,
                    textScaleFactor: 3.0,
                ), 
              ]
            ),
          onPressed: () {
            // Navigate to the second screen using a named route
            Navigator.pushNamed(context, '/second');
          })),
      ]);

}
}
