import 'package:sqflite/sqflite.dart';
import 'package:work_test/database/database.dart';
import 'package:work_test/models/human.dart';

/// Абстрактный класс для работы с БД
///
abstract class Repository<T extends DBEntity> {
  Repository({
    required this.table
  });

  /// Таблица, с которой происходит взаимодействие
  ///
  final Table table;

  String get _tableName => table.name;

  /// Возвращает объект формата "ключ": "значение" с информацией о строке
  /// таблицы по значению поля id
  ///
  Future<Map<String, Object?>> _getFromDbById(int id) async {
    final Database db = await DBProvider.db.database;

    List<Map<String, Object?>> table = await db.rawQuery(
        "SELECT * FROM $_tableName WHERE id = $id;"
    );

    Map<String, Object?> json = table.first;

    return json;
  }

  /// Добавляет запись в таблицу _tableName по предоставленной
  /// сущности типа <T>
  ///
  Future<bool> addToDB(T entity) async {
    final Database db = await DBProvider.db.database;
    List<Map<String, Object?>> table = await db.rawQuery("SELECT MAX(id)+1 as id FROM $_tableName");

    int? id = int.tryParse(table.first["id"].toString());

    entity.id = id;

    int res = await db.insert(_tableName, entity.toMap());

    return res == 1;
  }

  Future<DBEntity> getById(int id);
}

/// Класс для работы с таблицей "Employees"
///
class EmployeeRepository extends Repository<Employee> {
  EmployeeRepository() : super(table: Tables.employee);

  /// Возвращает объект Employee, отображающий строку таблицы Employees
  /// с предоставленным значением поля id
  ///
  Future<Employee> getById(int id) async {
    Map<String, Object?> json = await _getFromDbById(id);

    return Employee.fromMap(json);
  }
}

/// Класс для работы с таблицей "Children"
///
class ChildRepository extends Repository<Child> {
  ChildRepository() : super(table: Tables.child);

  /// Возвращает объект Child, отображающий строку таблицы Children
  /// с предоставленным значением поля id
  ///
  Future<Child> getById(int id) async {
    Map<String, Object?> json = await _getFromDbById(id);

    return Child.fromMap(json);
  }
}

/// Класс, через который можно получить список таблиц и их имен
///
class Tables {
  static Table employee = Table(name: 'Employees');
  static Table child = Table(name: 'Children');
}

/// Класс, содержащий информацию о таблице
class Table {
  Table({
    required this.name
  });

  final String name;
}
