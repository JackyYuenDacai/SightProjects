import 'package:flutter/material.dart';
import './columnWidget.dart';
import './RFIDPage.dart';
import './ManPage.dart';
import './pop.dart';
import './DataPage.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CaritasApp',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
          '/RFIDPage':(BuildContext context) => new RFIDPage(),
          '/ManPage':(BuildContext context) => new ManPage(),
          '/DataPage':(BuildContext context) => new DataPage(),
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
        child: Align(alignment: Alignment.center,child:new SingleChildScrollView (
          scrollDirection: Axis.horizontal,
          child: new Align(
            alignment: Alignment.center,
            child:new Row(
            //children:[]
            children:[

              new Column(children:[
                new SizedBox(height: 135),
                    GestureDetector(
                      onTap: (){
                        StaticList.location = 'A';
                        Navigator.of(context).pushNamed('/RFIDPage');
                      },
                      child: new CircleAvatar(child: new Icon(Icons.school),radius: 72.0,)
                    ),
                    new SizedBox(height: 35),
                    new Text("Location A",textAlign:TextAlign.center,style: new TextStyle(
                color: Colors.purple,
                fontSize: 40.0,
              )),]),
              new SizedBox(width:35),
              new Column(children:[
                new SizedBox(height: 135),
                    GestureDetector(
                      onTap: (){
                        StaticList.location = 'B';
                        Navigator.of(context).pushNamed('/RFIDPage');
                      },
                      child: new CircleAvatar(child: new Icon(Icons.school),radius: 72.0,)
                    ),
                    new SizedBox(height: 35),
                    new Text("Location B",textAlign:TextAlign.center,style: new TextStyle(
                color: Colors.purple,
                fontSize: 40.0,
              )),]),
              new SizedBox(width:35),
              new Column(children:[
                new SizedBox(height: 135),
                    GestureDetector(
                      onTap: (){
                        StaticList.location = 'C';
                        Navigator.of(context).pushNamed('/RFIDPage');
                      },
                      child: new CircleAvatar(child: new Icon(Icons.school),radius: 72.0,)
                    ),
                    new SizedBox(height: 35),
                    new Text("Location C",textAlign:TextAlign.center,style: new TextStyle(
                color: Colors.purple,
                fontSize: 40.0,
              )),]),
            ]
          ))
        )),),
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
              ListTile(title: Text('Data Analysis'),
                leading: new CircleAvatar(child: new Icon(Icons.school),),
                onTap: () {
                  Navigator.of(context).pushNamed('/DataPage');
                },),
            ListTile(title: Text('Manuel Page'),
              leading: new CircleAvatar(child: new Text('B2'),),
              onTap: () {
                //Navigator.pop(context);
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
