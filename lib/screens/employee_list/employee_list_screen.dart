import 'package:flutter/material.dart';
import 'package:work_test/screens/employee_list/widgets/body.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: EmployeeListScreenBody(),
    );
  }
}
