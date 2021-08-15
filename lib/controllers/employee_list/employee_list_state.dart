import 'package:work_test/models/human.dart';

enum EmployeeListStateType {LOADING, LOADED}

class EmployeeListState {
  EmployeeListState({required this.type, this.data});

  EmployeeListStateType type;
  List<Employee>? data;
}