import 'package:flutter/material.dart';
import 'package:work_test/screens/employee_list/widgets/body.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: EmployeeListScreenBody(),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                  },
                  child: Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () {
                  },
                  child: Icon(Icons.title),
                )
              ],
            )
          );
        },
      ),
    );
  }
}
