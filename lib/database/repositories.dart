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

  Future<void> dropTable() async {
    final Database db = await DBProvider.db.database;

    await db.execute('DROP TABLE $_tableName;');
  }

  Future<void> clearTable() async {
    final Database db = await DBProvider.db.database;

    await db.delete(_tableName);
  }

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

  /// Возвращает список объектов формата "ключ": "значение"
  ///
  Future<List<Map<String, Object?>>> _getAllStrings() async {
    final Database db = await DBProvider.db.database;

    List<Map<String, Object?>> table = await db.rawQuery(
        "SELECT * FROM $_tableName;"
    );

    return table;
  }

  /// Добавляет запись в таблицу _tableName по предоставленной
  /// сущности типа <T>
  ///
  Future<int> addToDB(T entity) async {
    final Database db = await DBProvider.db.database;
    List<Map<String, Object?>> table = await db.rawQuery("SELECT MAX(id)+1 as id FROM $_tableName");

    int? id = int.tryParse(table.first["id"].toString());

    entity.id = id;

    int res = await db.insert(_tableName, entity.toMap());

    return res;
  }

  Future<DBEntity> getById(int id);
  Future<List<DBEntity>> getAll();
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

  Future<List<Employee>> getAll() async {
    final List<Map<String, Object?>> jsonList = await _getAllStrings();
    List<Employee> employeeList = <Employee>[];

    jsonList.forEach((element) {
      employeeList.add(Employee.fromMap(element));
    });

    return employeeList;
  }

  Future<void> fillTable() async {
    final Database db = await DBProvider.db.database;

    for (int i = 0; i < 10; i++) {
      Map<String, Object?> employeeMap = Employee(
        name: 'Name ' + i.toString(),
        lastName: 'LastName ' + i.toString(),
        secondName: 'SecondName ' + i.toString(),
        age: i,
        position: 'Position ' + i.toString()
      ).toMap();

      await db.insert(_tableName, employeeMap);
    }

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

  Future<List<Child>> getAll() async {
    final List<Map<String, Object?>> jsonList = await _getAllStrings();
    List<Child> childList = <Child>[];

    jsonList.forEach((element) {
      childList.add(Child.fromMap(element));
    });

    return childList;
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
