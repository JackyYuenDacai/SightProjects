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
import 'package:flutter_range_slider/flutter_range_slider.dart';

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
    DateTime nowtmp = DateTime.now();

    DateTime nowDateTime = new DateTime(nowtmp.year, nowtmp.month, nowtmp.day+1, 0, 0);
/*
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
    }*/
    
    class ScatteredData{
      final int date;
      final double time;
      final double radius;
      ScatteredData(this.date,this.time.this.radius);
    }
        DateTime start = nowDateTime.subtract(new Duration(months:_upperValue));
        DateTime end = nowDateTime.subtract(new Duration(months:_lowerValue));
        //var timestring = DateFormat('dd').format(start)+"-"+DateFormat('MM/dd').format(end);
        //var timestring2 = DataFormat('hh').format(start);
    
        int sum = 0;
        bool _assigned_time = false;
        DataTime _time_in;
        if(StaticList?.entries?.entries != null)
        for(record_entry ent in StaticList.entries.entries){

          if(ent.time_in.isAfter(start) == true && ent.time_in.isBefore(end) == true){
            print(timestring);
            _assigned_time = ent.data_json['assigned_time'] == 'true';
            _time_in = ent.data.time_in;
            var _date = DateFormat('dd').format(_time_in);
            var _time = DateFormat('hh').format(_time_in);
            var _time2 = DateFormat('mm').format(_time_in);
            var _time3 = _time + _time2/60;
            data.add(new ScatteredData(_date,_time3,2))  //2 is radius of the dot
          }
        
    
    /*
    chart_series.add(
      new charts.Series<ClicksPerYear,String>(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Success rate',
        data: data,
    ));
*/
    charts.Series<ScatteredData, int>(
        id: 'Date';
        domainFn: (ScatteredData sales, _) => sales.year,
        measureFn: (ScatteredData sales, _) => sales.sales,
        // Providing a radius function is optional.
        radiusPxFn: (ScatteredData sales, _) => sales.radius,
        data: data,
      )
      
    chart = new charts.ScatterPlotChart(seriesList, animate: animate);
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
      new RangeSlider(
                    min: 0,
                    max: 13,
                    lowerValue: _lowerValue,
                    upperValue: _upperValue,
                    divisions: 1,
                    showValueIndicator: true,
                    valueIndicatorMaxDecimals: 0,
                    onChanged: (int newLowerValue, int newUpperValue) {
                      setState(() {
                        _lowerValue = newLowerValue;
                        _upperValue = newUpperValue;
                      });
                    },
                    onChangeStart:
                        (int startLowerValue, int startUpperValue) {
                      print(
                          'Started with values: $startLowerValue and $startUpperValue');
                    },
                    onChangeEnd: (int newLowerValue, int newUpperValue) {
                      print(
                          'Ended with values: $newLowerValue and $newUpperValue');
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
