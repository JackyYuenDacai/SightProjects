import 'package:sqflit/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:caritas_app/models/note.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;   //Singleton DatabaseHelper
  static Database _database;               //Singleton Database

  String studentsData = 'students_data';
  String colId = 'id';
  String colName = 'name';
  String colTime = 'time';
  String colAnswer = 'answer';





  DatabaseHelper._createInstance();   //Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }


  Future<Database>  initializeDatabase() async{
    // Get the directory path for both android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'students.db';

    //Open/create the database at a given path
    var studentsDatabase = await openDatabase(path, version: 1, onCreate:_createDb);
    return studentsDatabase;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $studentsData'
    '($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
    '$colName TEXT,$colTime TEXT,$colAnswer TEXT)');
  }
  // Fetch Operation: Get all note objects from database
	Future<List<Map<String, dynamic>>> getNoteMapList() async {
		Database db = await this.database;

  // var result = await db.rawQuery('SELECT * FROM $studentsData order by $colTime ASC');
		var result = await db.query(studentsData, orderBy: '$colTime ASC');
		return result;
	}

	// Insert Operation: Insert a Note object to database
	Future<int> insertNote(Note note) async {
		Database db = await this.database;
		var result = await db.insert(studentsData, note.toMap());
		return result;
	}

	// Update Operation: Update a Note object and save it to database
	Future<int> updateNote(Note note) async {
		var db = await this.database;
		var result = await db.update(studentsData, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
		return result;
	}

	// Delete Operation: Delete a Note object from database
	Future<int> deleteNote(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $studentsData WHERE $colId = $id');
		return result;
	}

	// Get number of Note objects in database
	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $studentsData');
		int result = Sqflite.firstIntValue(x);
		return result;
	}
}