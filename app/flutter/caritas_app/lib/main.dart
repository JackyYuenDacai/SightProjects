import 'package:flutter/material.dart';
import './columnWidget.dart';
import './RFIDPage.dart';
import './ManPage.dart';
import './pop.dart';
import './DataPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './I8N.dart';
import 'network_request.dart';
import 'SettingPage.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CaritasApp',
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (BuildContext context) => I8N.of(context).apptitle,
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        const I8NDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
         const Locale('en'), // English
         const Locale('zh'), // Chinese
         const Locale.fromSubtags(languageCode: 'zh'), // generic Chinese 'zh'
         const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'), // generic simplified Chinese 'zh_Hans'
         const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'), // generic traditional Chinese 'zh_Hant'
         const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans', countryCode: 'CN'), // 'zh_Hans_CN'
         const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'), // 'zh_Hant_TW'
         const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant', countryCode: 'HK'), // 'zh_Hant_HK'

       ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
          '/RFIDPage':(BuildContext context) => new RFIDPage(),
          '/ManPage':(BuildContext context) => new ManPage(),
          '/DataPage':(BuildContext context) => new DataPage(),
          '/SettingPage':(BuildContext context) => new SettingPage(),
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

    return
    new WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(appBar: new AppBar(title: Text(I8N.of(context).home),),
          body: new Container(
            child: Align(alignment: Alignment.center,child:new SingleChildScrollView (
              scrollDirection: Axis.horizontal,
              child: new Align(
                alignment: Alignment.center,
                child:new Row(
                  children:
                    <String>['A','B','C'].map((String title) {return new Row(children:<Widget>[
                        new SizedBox(width:35),
                        new Column(children:[
                          new SizedBox(height: 135),
                              GestureDetector(
                                onTap: (){
                                  StaticList.location = title;
                                  Navigator.of(context).pushNamed('/RFIDPage');
                                },
                                child: new CircleAvatar(child: new Icon(Icons.school),radius: 72.0,)
                              ),
                              new SizedBox(height: 35),
                              new Text((I8N.of(context).location_text ?? 'Location ')+title,textAlign:TextAlign.center,style: new TextStyle(
                          color: Colors.purple,
                          fontSize: 40.0,
                        )),]),
                        new SizedBox(width:35),
                      ]
                    );}).toList()

              ))
            )),),
        )
  );
  }
}
