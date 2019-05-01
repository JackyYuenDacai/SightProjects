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
  void showMyMaterialDialog(BuildContext context) {
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

    showMyMaterialDialog(context);
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
            child: new Text(name),
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
          //onTap: () => _showSnackBar('Export'),
        ),
      ],
      secondaryActions: <Widget>[
        new IconSlideAction(
          caption: 'More',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () => fetchUserData(context),
        ),
        new IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => print('delete '+name),
        ),
      ],
    ));
    /*return (new Row(
              children: <Widget>[
                new SizedBox(width:15.0),
                new Container(
                  width:350.0,
                  child:
                new Text(name,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 32.0,color: Colors.blue),
                  )
                )
                ,
                new SizedBox(width:15.0),
                new RaisedButton(
                  onPressed: (){
                      fetchUserData(context);
                  },
                  textColor: Colors.white,
                  color: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "View",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 32.0,color: Colors.blue),
                  ),
                  )
              ]
            )

    );*/
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
    switch(_value?.toInt() ?? 0){
      case 0:
      for(int i = 8; i>0;i--){
        DateTime start = (new DateTime.now()).subtract(new Duration(days:7*i+1));
        DateTime end = (new DateTime.now()).subtract(new Duration(days:7*(i-1)+1));
        var timestring = DateFormat('MM/dd').format(start)+"-"+DateFormat('MM/dd').format(end);

        int sum = 0;

        for(record_entry ent in StaticList.entries.entries){
          if(ent.time_in.isAfter(start) && ent.time_in.isBefore(end)){
            sum += ent.data_json['select0'].toInt();
          }
        }
        data.add(new ClicksPerYear(timestring,sum,Colors.red));
      }
      break;
      case 1:
      for(int i = 8; i>0;i--){
        DateTime start = (new DateTime.now()).subtract(new Duration(days:30*i+1));
        DateTime end = (new DateTime.now()).subtract(new Duration(days:30*(i-1)+1));
        var timestring = DateFormat('MM/dd').format(start)+"-"+DateFormat('MM/dd').format(end);

        int sum = 0;

        for(record_entry ent in StaticList.entries.entries){
          if(ent.time_in.isAfter(start) && ent.time_in.isBefore(end)){
            sum += ent.data_json['select0'].toInt();
          }
        }
        data.add(new ClicksPerYear(timestring,sum,Colors.blue));
      }
      break;
      case 2:
      for(int i = 8; i>0;i--){
        DateTime start = (new DateTime.now()).subtract(new Duration(days:365*i+1));
        DateTime end = (new DateTime.now()).subtract(new Duration(days:365*(i-1)+1));
        var timestring = DateFormat('yyyy').format(start);

        int sum = 0;

        for(record_entry ent in StaticList.entries.entries){
          if(ent.time_in.isAfter(start) && ent.time_in.isBefore(end)){
            sum += ent.data_json['select0'].toInt();
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
          onChanged: (newValue) {setState((){_value = newValue;getRecord();});},
          onChangeStart: (startValue) {
            //print('onChangeStart:$startValue');
          },
          onChangeEnd: (endValue) {
            //print('onChangeEnd:$endValue');
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
