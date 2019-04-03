import 'package:flutter/material.dart';

import './columnWidget.dart';
import './RFIDPage.dart';
import './ManPage.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CaritasApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
          '/RFIDPage':(BuildContext context) => new RFIDPage(),
          '/ManPage':(BuildContext context) => new ManPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    Widget userHeader = UserAccountsDrawerHeader(
      accountName: new Text('Location'),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: AssetImage('images/pic1.jpg'), radius: 35.0,),);

    return Scaffold(appBar: AppBar(title: Text("Home"),),
      body: new Container(
        child: new SingleChildScrollView (
          scrollDirection: Axis.horizontal,
          child: new Row(
            children:[
            new ColForm(),new ColForm(),]
          )
        ),),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            userHeader , 
            ListTile(title: Text('RFID Page'),
              leading: new CircleAvatar(child: new Icon(Icons.school),),
              onTap: () {
                Navigator.of(context).pushNamed('/RFIDPage');
              },),
            ListTile(title: Text('Manuel Page'),
              leading: new CircleAvatar(child: new Text('B2'),),
              onTap: () {
                Navigator.of(context).pushNamed('/ManPage');
              },),
            ListTile(title: Text('Settings'),
              leading: new CircleAvatar(
                child: new Icon(Icons.list),),
              onTap: () {
                Navigator.pop(context);
              },),
          ],
        ),
      ),);
  }
}

