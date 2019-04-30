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
  http.Response ajaxResponse = new http.Response("",200);
  _DataFormState([String n='Name',String i='Id']):name=n,id=i{

  }

  void showMyMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text("Record of "+name),
            content: new Column(children:<Widget>[
              chartWidget
            ]),
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
    ajaxResponse = new http.Response("",200);;
    var url = StaticList.get_record_data_url+"id="+id+"&time="+"1980-00-00 00:00:00";
    //print(url);
    http.get(url)
        .then((response) {
      //print("Response status: ${response.statusCode}");

          print("Response body: ${response.body}");
          print('get record data');
          if(response.body.length<=0){
            return;
          }
          record_entries entries = new record_entries.fromJson(json.decode(response.body));
          for(record_entry ent in entries.entries){
            //print(ent.time_in);
          }
          //studentList staffs = new studentList.fromJson(json.decode(response.body));
          //StaticList.student_id.clear();
          //StaticList.student_name.clear();
          //for(student wid in staffs.Staffs){
          //  this.setState((){
              //StaticList.student_id.add(wid.id);
              //print('name:'+wid.name);
              //StaticList.student_name.add(wid.name);
              //datform_list.add(new DataForm(wid.name,wid.id));
          //  });

          //}

          //ajaxCall.reset();
    });
    showMyMaterialDialog(context);
  }
  initState(){
    super.initState();
    var data = [
      new ClicksPerYear('2016', 12, Colors.red),
      new ClicksPerYear('2017', 42, Colors.green),
      new ClicksPerYear('2018', 50, Colors.blue),
    ];
    var data1 = [
      new ClicksPerYear('2016', 12, Colors.red),
      new ClicksPerYear('2017', 42, Colors.green),
      new ClicksPerYear('2018', 50, Colors.blue),
    ];

    var series = [
      new charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
      new charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks1',
        data: data1,
      ),
    ];

    chart = new charts.BarChart(
    series,
    animate: true,barGroupingType: charts.BarGroupingType.grouped,

    );
    chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 250.0,
        child: chart,
      ),
    );

  }
  @override
  Widget build(BuildContext context) {

    return (new Row(
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

    );
  }
}
