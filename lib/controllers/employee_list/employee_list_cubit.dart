import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_test/controllers/employee_list/employee_list_state.dart';
import 'package:work_test/database/repositories.dart';
import 'package:work_test/models/human.dart';

class EmployeeListCubit extends Cubit<EmployeeListState> {

  EmployeeListCubit() : super(
      EmployeeListState(type: EmployeeListStateType.LOADING)
  );

  static EmployeeRepository _repository = EmployeeRepository();
  List<Employee> _employeeList = <Employee>[];

  void getEmployeeList() async {
    _employeeList = await _repository.getAll();

    _emitState(
        type: EmployeeListStateType.LOADED,
        data: _employeeList
    );
  }

  void _emitState({required EmployeeListStateType type, List<Employee>? data}) {
    emit(
      EmployeeListState(
        type: type,
        data: data
      )
    );
  }

  void refresh() {
    _emitState(type: EmployeeListStateType.LOADING);
  }
}