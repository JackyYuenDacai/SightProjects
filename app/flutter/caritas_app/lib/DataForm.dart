import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';
import 'package:async/async.dart';
import './ManPage.dart';
import 'RFIDPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pop.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:share_extend/share_extend.dart';

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
class DataForm extends StatefulWidget{
  String name,id;
  DataForm([String n='Name',String i='Id']) : name=n,id=i
  {

  }
  @override
  _DataFormState createState() => new _DataFormState(name,id);
}
class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
class _DataFormState extends State<DataForm> with SingleTickerProviderStateMixin {
  String name,id;
  var chart;
  var chartWidget;
  double _value ;
  http.Response ajaxResponse = new http.Response("",200);
  _DataFormState([String n='Name',String i='Id']):name=n,id=i{

  }
  void refresh(){
    setState((){

    });
  }
  _onDelStudent(){
    if(!RFIDPage.IsNetwork){
        print('no network');
    }else{
      var url = StaticList.del_student_api_url;
      url = url + 'id=' + id +'&';
      http.get(url)
          .then((response) {
            //print("Submit Response status: ${response.statusCode}");
            print("Submit: ${response.body}");
            if(response.body.length>0){

            }
          });
    }
  }
  void deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text("Delete "+name),
            content: new Text('  '),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _onDelStudent();

                  this.setState((){
                    //this.dispose();
                    StaticList.datform_list.remove(this);
                    //Navigator.of(context).pushNamed('/DataPage');
                  });

                },
                child: new Text("Confirm"),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Cancel"),
              ),
            ],
          );
        });
  }
  void getRecordData(String id){
    ajaxResponse = new http.Response("",200);
    var url = StaticList.get_record_export_url+"id="+id+"&time=1980-00-00%2000:00";
    String retCSVdata ="";
    print(url);
    http.get(url)
        .then((response) {
          print("Response body: ${response.body.substring(0)}");
          this.ajaxResponse = (response);
          if(this.ajaxResponse.body.length<=0){
            return;
          }
          shareCSV(response.body);
          //retCSVdata = response.body.substring(0);

    });
    //print(retCSVdata);
    //return retCSVdata;
  }
  void shareCSV(String csvData) async{
    Directory dir = await getApplicationDocumentsDirectory();
    File testFile = new File("${dir.path}/flutter/export.csv");
    if (!await testFile.exists()) {
      await testFile.create(recursive: true);

    }
    testFile.writeAsStringSync(csvData);
    print(csvData);
    ShareExtend.share(testFile.path, "file");
  }
  void modifyDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text("Modify "+name),
            content: new Text('  '),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Confirm"),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Cancel"),
              ),
            ],
          );
        });
  }
  void recordDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text("Record of "+name),
            content: new DialogContent(name,id),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Confirm"),
              ),
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text("Cancel"),
              ),
            ],
          );
        });
  }
  fetchUserData(BuildContext context){
    recordDialog(context);
  }
  initState(){
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return
      Container(
        width:550.0,
        height:70,
        child:new Slidable(
      delegate: new SlidableDrawerDelegate(),
      actionExtentRatio: 0.25,
      child: new Container(
        color: Colors.white,
        child: new ListTile(
          leading: new CircleAvatar(
            backgroundColor: Colors.indigoAccent,
            child: new Text(name.substring(0,1)),
            foregroundColor: Colors.white,
          ),
          title: new Text(name),
          subtitle: new Text(id),
        ),
      ),
      actions: <Widget>[

        new IconSlideAction(
          caption: 'Export',
          color: Colors.indigo,
          icon: Icons.share,
          onTap: () => getRecordData(id),
        ),
      ],
      secondaryActions: <Widget>[
        new IconSlideAction(
          caption: 'Records',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => fetchUserData(context),
        ),
        new IconSlideAction(
          caption: 'Modify',
          color: Colors.blue,
          icon: Icons.mode_edit,
          onTap: () => modifyDialog(context),
        ),
        new IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => deleteDialog(context),
        ),
      ],
    ));
  }
}

class DialogContent extends StatefulWidget{
  final String name;
  final String id;
  DialogContent(this.name,this.id);
  @override
  _DialogContentState createState() => new _DialogContentState(name,id);
}
class _DialogContentState extends State<DialogContent>{
  final String name;
  final String id;
  var chart;
  var chartWidget;
  record_entries entries;
  http.Response ajaxResponse = new http.Response("",200);
  List<String> Divisions = <String>['Weeks','Months','Years'];
  double _value;
  _DialogContentState(this.name,this.id);
  @override void initState(){
    super.initState();
    getRecord();
  }
  getRecord(){

    DateTime now = new DateTime.now();DateTime desire;
    switch(_value?.toInt() ?? 0){
        case 0://WEEK
          desire = now.subtract(new Duration(days:7*10+1));
          break;
        case 1://MONTH
          desire = now.subtract(new Duration(days:30*10+1));
          break;
        case 2://YEAR
          desire = now.subtract(new Duration(days:10*365+1));
          break;
        default:
          desire = now.subtract(new Duration(days:7*10+1));
          break;
    }
    ajaxResponse = new http.Response("",200);
    var url = StaticList.get_record_data_url+"id="+id+"&time="+DateFormat('yyyy-MM-dd HH:mm:ss').format(desire);
    print(url);
    http.get(url)
        .then((response) {
      //print("Response status: ${response.statusCode}");

          print("Response body: ${response.body}");
          print('get record data');
          if(response.body.length<=0){
            return;
          }
          StaticList.entries = new record_entries.fromJson(json.decode(response.body));
          for(record_entry ent in StaticList.entries.entries){
            print(ent.time_in);
          }
    });

    //List<List<ClicksPerYear>> data;
    List<ClicksPerYear> data =[];
    List<charts.Series<ClicksPerYear,String>> chart_series =[];
    DateTime nowDateTime = new DateTime.now();
    switch(_value?.toInt() ?? 0){
      case 0:
      for(int i = 8; i>0;i--){
        DateTime start = nowDateTime.subtract(new Duration(days:7*i));
        DateTime end = nowDateTime.subtract(new Duration(days:7*(i-1)));
        var timestring = DateFormat('MM/dd').format(start)+"-"+DateFormat('MM/dd').format(end);

        int sum = 0;
        if(StaticList?.entries?.entries != null)
        for(record_entry ent in StaticList.entries.entries){

          if(ent.time_in.isAfter(start) == true && ent.time_in.isBefore(end) == true){
            print(timestring);
            sum += 1;//int.parse(ent.data_json['select0']);
          }
        }
        data.add(new ClicksPerYear(timestring,sum,Colors.red));
      }
      break;
      case 1:
      for(int i = 8; i>0;i--){
        DateTime start = (new DateTime.now()).subtract(new Duration(days:30*i));
        DateTime end = (new DateTime.now()).subtract(new Duration(days:30*(i-1)));
        var timestring = DateFormat('MM/dd').format(start)+"-"+DateFormat('MM/dd').format(end);

        int sum = 0;

        for(record_entry ent in StaticList.entries.entries){
          if(ent.time_in.isAfter(start) && ent.time_in.isBefore(end)){
            sum += 1;//int.parse(ent.data_json['select0']);
          }
        }
        data.add(new ClicksPerYear(timestring,sum,Colors.blue));
      }
      break;
      case 2:
      for(int i = 8; i>0;i--){
        DateTime start = (new DateTime.now()).subtract(new Duration(days:365*i));
        DateTime end = (new DateTime.now()).subtract(new Duration(days:365*(i-1)));
        var timestring = DateFormat('yyyy').format(start);

        int sum = 0;

        for(record_entry ent in StaticList.entries.entries){
          if(ent.time_in.isAfter(start) && ent.time_in.isBefore(end)){
            sum += 1;//int.parse(ent.data_json['select0']);
            print(timestring);
          }
        }
        data.add(new ClicksPerYear(timestring,sum,Colors.green));
      }
      break;
    }
    chart_series.add(
      new charts.Series<ClicksPerYear,String>(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Success rate',
        data: data,
    ));

    chart = new charts.BarChart(
      chart_series,
      animate: true,
      barGroupingType: charts.BarGroupingType.groupedStacked,
      behaviors: [new charts.SeriesLegend()],
      );
      chartWidget = new Padding(
        padding: new EdgeInsets.all(32.0),
        child: new SizedBox(
          width:700.0,
          height: 250.0,
          child: chart,
        ),
      );

  }
  _getContent(){
    return new Column(children:<Widget>[
      new Text(
        'Display according to...',
        style: new TextStyle(
          color: Colors.blue,
          fontSize: 25.0,
          )
      ),
      new Slider(
          min:0,
          max:2,
          value: _value == null? 0.0:_value ,
          onChanged: (newValue) {setState((){_value = newValue;});},
          onChangeStart: (startValue) {
            //print('onChangeStart:$startValue');
          },
          onChangeEnd: (newValue) {
            setState((){
              getRecord();
            });
          },
          label: Divisions[_value?.toInt() ?? 0],
          divisions: 3,
          semanticFormatterCallback: (newValue) {
            return '${newValue.round()} dollars';
          },
        ),
      chartWidget,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}
