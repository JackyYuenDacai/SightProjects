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

import 'network_request.dart';

import 'I8N.dart';

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
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
    DateTime now = new DateTime.now();
    DateTime desire;
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
    network_request.get_record_data(id,DateFormat('yyyy-MM-dd HH:mm:ss').format(desire));
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
