//Builded base on tutorial 4.6

class Note {
  int _id;
  String _name;
  String _time;
  String _answer;

  Note(this._name, this._time, [this._answer]); //'[]'to make it optional

  Note.wihtId(this._id, this._name, this._time,
      [this._answer]); //'[]'to make it optional

  int get id => _id;
  String get name => _name;
  String get time => _time;
  String get answer => _answer;

//These are the constrain before sending to database
  set id(int newId) {
    if (newId <= 20) {
      this._id = newId;
    }
  }

  set time(String newTime) {
    if (newTime.length <= 20) {
      this._time = newTime;
    }
  }

//Convert a Note object into a Map object
  Map<String, dynamic> toMap() {       //dynamic is used because the value can be string and integer
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['time'] = _time;
    map['answer'] = _answer;

    return map;
  }

//Extract a Note object from a Map object
Note.fromMapObject(Map<String,dynamic> map){
  this._id = map['id'];
  this._name = map['name'];
  this._time = map['time'];
  this._answer = map['answer'];
}

}
