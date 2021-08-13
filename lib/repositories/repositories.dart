import 'package:sqflite/sqflite.dart';
import 'package:work_test/database/database.dart';
import 'package:work_test/models/human.dart';

abstract class Repository<T extends DBEntity> {
  Repository({
    required this.tableName
  });

  final String tableName;

  Future<Map<String, Object?>> _getFromDbById(int id) async {
    final Database db = await DBProvider.db.database;

    List<Map<String, Object?>> table = await db.rawQuery(
        "SELECT * FROM $tableName WHERE id = $id;"
    );

    Map<String, Object?> json = table.first;

    return json;
  }

  Future<bool> addToDB(T entity) async {
    final Database db = await DBProvider.db.database;
    List<Map<String, Object?>> table = await db.rawQuery("SELECT MAX(id)+1 as id FROM $tableName");

    int? id = int.tryParse(table.first["id"].toString());

    entity.id = id;

    int res = await db.insert(tableName, entity.toMap());

    return res == 1;
  }

  Future<DBEntity> getById(int id);
}

class EmployeeRepository extends Repository<Employee> {
  EmployeeRepository() : super(tableName: 'Employee');

  Future<Employee> getById(int id) async {
    Map<String, Object?> json = await _getFromDbById(id);

    return Employee.fromMap(json);
  }
}

class ChildRepository extends Repository<Child> {
  ChildRepository() : super(tableName: 'Children');

  Future<Child> getById(int id) async {
    Map<String, Object?> json = await _getFromDbById(id);

    return Child.fromMap(json);
  }
}