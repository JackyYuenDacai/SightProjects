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
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:io';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'network_request.dart';

import 'I8N.dart';

class ClicksPerYear {
  final int year;
  final double clicks;
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
  var numWidget;
  record_entries entries;
  http.Response ajaxResponse = new http.Response("",200);
  List<String> Divisions = <String>['Weeks','Months','Years'];
  DateTime _selected_month;
  _DialogContentState(this.name,this.id);
  @override void initState(){
    super.initState();
    DateTime nowtmp = DateTime.now();
    DateTime nowDateTime = new DateTime(nowtmp.year, nowtmp.month, 0, 0, 0);
    _selected_month = nowDateTime;
    getRecord();
  }
  int record_sum = 0;
  int success_sum = 0;
  int toilet_wee_sum = 0;
  int toilet_poo_sum = 0;
  int clean_diaper_sum = 0;
  int clean_diaper_poo = 0;
  int clean_diaper_wee = 0;
  getRecord(){
    DateTime now = new DateTime.now();
    DateTime desire = _selected_month;

    record_sum = 0;
    success_sum = 0;
    toilet_wee_sum = 0;
    toilet_poo_sum = 0;
    clean_diaper_sum = 0;
    clean_diaper_poo = 0;
    clean_diaper_wee = 0;
    //print('DESIRE');
    //print(desire);
    network_request.get_record_data(id,DateFormat('yyyy-MM-dd HH:mm:ss').format(desire));
    List<ClicksPerYear> data =[];
    List<charts.Series<ClicksPerYear,int>> chart_series =[];
    DateTime nowtmp = desire;
    DateTime nowDateTime = new DateTime(nowtmp.year, nowtmp.month, 0, 0, 0);
    DateTime endDateTime = new DateTime(nowtmp.year, nowtmp.month+1 , 0, 0, 0);

    if(StaticList?.entries?.entries != null)
    for(record_entry ent in StaticList.entries.entries){
      if(ent.time_in.isAfter(nowDateTime) == true && ent.time_in.isBefore(endDateTime) == true){
        record_sum ++;
        //print(ent.data_json);
        var timestring = DateFormat('MM/dd').format(ent.time_in);
        if(ent.data_json['toilet'] == 'wee' || ent.data_json['toilet'] == 'poo'){
          success_sum ++;

          if(ent.data_json['toilet'] == 'wee')
            toilet_wee_sum ++;
          else
            toilet_poo_sum ++;
            if(ent.data_json['assigned_time'] == true)
              data.add(new ClicksPerYear(ent.time_in.day,ent.time_in.hour+ent.time_in.minute/60,Colors.green));
            else
              data.add(new ClicksPerYear(ent.time_in.day,ent.time_in.hour+ent.time_in.minute/60,Colors.blue));
        }else{
              data.add(new ClicksPerYear(ent.time_in.day,ent.time_in.hour+ent.time_in.minute/60,Colors.red));
        }
        if(ent.data_json['diaper'] == 'dirty'){
          clean_diaper_sum ++;
        }
        if(ent.data_json['mistake'] == 'wee')
          clean_diaper_wee ++;
        if(ent.data_json['mistake'] == 'poo')
          clean_diaper_poo ++;
        if(ent.data_json['mistake'] == 'both'){
          clean_diaper_wee ++;
          clean_diaper_poo ++;
        }

      }
    }

    chart_series.add(
      new charts.Series<ClicksPerYear,int>(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        radiusPxFn: (ClicksPerYear clickData, _) => 4.0,
        id: 'Success rate',
        data: data,
    ));

      chart = new charts.ScatterPlotChart(
        chart_series,
        animate: true,
        behaviors: [
        new charts.ChartTitle('日期（日）',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        new charts.ChartTitle('時間（時）',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),

      ],
      );
      chartWidget = new Padding(
        padding: new EdgeInsets.all(32.0),
        child:
          new SingleChildScrollView (
              scrollDirection: Axis.horizontal,
              child:
                new SizedBox(
                    width:1500.0,
                    height: 450.0,
                    child:
                      chart
                    )
                  ),
      );

      setState((){});
      setState((){});
  }
  _getContent(){
    return
    new SingleChildScrollView (
        scrollDirection: Axis.vertical,
        child:
    new Column(children:<Widget>[
      Align(alignment: Alignment.topLeft,child:
      FlatButton(
        onPressed: () {
          showMonthPicker(
                context: context,
                initialDate: _selected_month)
            .then(
              (date) {
                      _selected_month = date;
                      getRecord();
                    }

                    );


                  },
        child: Text(
            '選擇月份',
            style: TextStyle(color: Colors.blue,fontSize:25.0,),
        ))),
      chartWidget,
      new Column(
        children:<Widget>[

          new Row(
            children:<Widget>[
              new Text(
                'Number of record',
                style: TextStyle(color: Colors.blue,fontSize:20.0,),
              ),
              new SizedBox(width:10.0),
              new Text(
                record_sum.toString(),
                style: TextStyle(color: Colors.blue,fontSize:20.0,),
              )
            ]
          ),
          new Row(
            children:<Widget>[
              new Text(
                'Number of success',
                style: TextStyle(color: Colors.blue,fontSize:20.0,),
              ),
              new SizedBox(width:10.0),
              new Text(
                success_sum.toString(),
                style: TextStyle(color: Colors.blue,fontSize:20.0,),
              )
            ]
          ),
          new Row(
            children:<Widget>[
              new Text(
                'Number of mistake',
                style: TextStyle(color: Colors.blue,fontSize:20.0,),
              ),
              new SizedBox(width:10.0),
              new Text(
                clean_diaper_sum.toString(),
                style: TextStyle(color: Colors.blue,fontSize:20.0,),
              )
            ]
          ),
        ]
      ),
    ]));
  }
  @override
  Widget build(BuildContext context) {
    return _getContent();
  }
}
