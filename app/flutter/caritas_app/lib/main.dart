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
    // When we navigate to the "/" route, build the FirstScreen Widget
    '/first': (context) => ManPage(),
    // When we navigate to the "/second" route, build the SecondScreen Widget
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
        Expanded(
            child: FlatButton(child: Column(
              children: <Widget>[
                Expanded(child: SizedBox()),
                Center(child: CircleAvatar(child: Icon(Icons.school), radius: 60.0)),
                Center(
                  child: SizedBox(height: 35),
                ),
                Center(
                  child: Text(
                    'Staff',
                    textAlign: TextAlign.center,
                    textScaleFactor: 3.0,
                  ),
                ),
                Expanded(child:SizedBox() ),            
              ]
            ),
          onPressed: () {
            // Navigate to the second screen using a named route
            Navigator.pushNamed(context, '/first');
          })),
                Expanded(
            child: FlatButton(child: Column(
              children: <Widget>[
                Expanded(child: SizedBox()),
                Center(child: CircleAvatar(child: Icon(Icons.school), radius: 60.0)),
                Center(
                  child: SizedBox(height: 35),
                ),
                Center(
                  child: Text(
                    'Toilet iPad',
                    textAlign: TextAlign.center,
                    textScaleFactor: 3.0,
                  ),
                ),
                Expanded(child:SizedBox() ),            
              ]
            ),
          onPressed: () {
            // Navigate to the second screen using a named route
            Navigator.pushNamed(context, '/second');
          })),
      ]);

}
}
