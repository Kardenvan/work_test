import 'package:flutter/material.dart';
import 'package:work_test/components/custom_title.dart';
import 'package:work_test/models/human.dart';

class EmployeeListScreenBody extends StatefulWidget {
  const EmployeeListScreenBody({Key? key}) : super(key: key);

  @override
  _EmployeeListScreenBodyState createState() => _EmployeeListScreenBodyState();
}

class _EmployeeListScreenBodyState extends State<EmployeeListScreenBody> {

  static List<Employee>? _employeeList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitle(title: 'Список сотрудников'),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: _getListWidget()
          )
        ],
      ),
    );
  }

  Widget _getEmployeeListWidget() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            child: Text('Employee ' + index.toString()),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: _employeeList!.length
    );
  }
  
  Widget _getEmptyListOfWidgets() {
    return Center(
        child: Text(
          'Не найдено ни одного сотрудника. Для добавления сотрудника нажмите кнопку "+" в правом нижнем углу экрана',
          textAlign: TextAlign.justify,
        ),
    );
  }
  
  Widget _getListWidget() {
    return _employeeList != null ?
      _getEmployeeListWidget() :
      _getEmptyListOfWidgets()
    ;
  }

}
