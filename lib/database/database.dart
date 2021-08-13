import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + "TestDB.db";

    return await openDatabase(
        path,
        version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(
            "CREATE TABLE Employees ("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "last_name TEXT,"
              "second_name TEXT,"
              "age INTEGER,"
              "position TEXT"
            ")"
          );

          await db.execute(
            "CREATE TABLE Children ("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "last_name TEXT,"
              "second_name TEXT,"
              "age INTEGER,"
              "parent_id INT"
            ")"
          );
        }
    );
  }

}
