abstract class DBEntity {
  int? id;

  DBEntity({
    this.id
  });

  Map<String, dynamic> toMap();
}

abstract class Human extends DBEntity {
  final String lastName;
  final String name;
  final String? secondName;
  final int age;

  Human({
    id,
    required this.lastName,
    required this.name,
    required this.age,
    this.secondName
  }) : super(
      id: id
  );
}

class Employee extends Human {
  Employee({
    required this.position,
    required String lastName,
    required String name,
    required int age,
    int? id,
    String? secondName
  }) :
  super(
    id: id,
    lastName: lastName,
    name: name,
    age: age,
    secondName: secondName,
  );

  final String position;

  factory Employee.fromMap(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      lastName: json['last_name'],
      name: json['name'],
      secondName: json['second_name'],
      age: json['age'],
      position: json['position']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "last_name": lastName,
      "name": name,
      "second_name": secondName,
      "position": position
    };
  }
}

class Child extends Human {
  Child({
    required this.parentId,
    int? id,
    required String lastName,
    required String name,
    required int age,
    String? secondName
  }) : super(
      id: id,
      lastName: lastName,
      name: name,
      age: age,
      secondName: secondName,
  );

  final int parentId;

  factory Child.fromMap(Map<String, dynamic> json) {

    return Child(
        id: json['id'],
        lastName: json['last_name'],
        name: json['name'],
        secondName: json['second_name'],
        age: json['age'],
        parentId: json['parent_id']
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> jsonMap = {
      "last_name": lastName,
      "name": name,
      "second_name": secondName,
      "parent_id": parentId,
      "age": age
    };

    if (id != null) {
      jsonMap['id'] = id;
    }

    return jsonMap;
  }
}