import 'package:json_annotation/json_annotation.dart';
import 'columnWidget.dart';
class pop{
  pop(this.name,this.id,this.status,this.unitok);
  final String name;
  final String id;
  final String status;
  final String unitok;
  factory pop.fromJson(Map<String,dynamic> json){
    return new pop(json['name'],
      json['id'],
      json['status'],
      json['unitok'],
    );
  }
}

class popList{
  final List<pop> Pops;
  popList({this.Pops,});
  factory popList.fromJson(List<dynamic> json){
    List<pop> Pops = new List<pop>();
    Pops = json.map((i)=>pop.fromJson(i)).toList();
    return new popList(Pops:Pops);
  }
}
class StaticList{
  static List<ColForm> colform_list = new List<ColForm>();
}
