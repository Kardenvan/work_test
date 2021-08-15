import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_test/components/custom_title.dart';
import 'package:work_test/controllers/employee_list/employee_list_cubit.dart';
import 'package:work_test/controllers/employee_list/employee_list_state.dart';
import 'package:work_test/database/repositories.dart';
import 'package:work_test/models/human.dart';

class EmployeeListScreenBody extends StatefulWidget {
  const EmployeeListScreenBody({Key? key}) : super(key: key);

  @override
  _EmployeeListScreenBodyState createState() => _EmployeeListScreenBodyState();
}

class _EmployeeListScreenBodyState extends State<EmployeeListScreenBody> {

  ScrollController _scrollController = ScrollController();
  EmployeeListCubit? _cubit;
  Size? _size;
  List<Employee>? _employeeList;

  @override
  Widget build(BuildContext context) {

    return BlocProvider<EmployeeListCubit>(
      create: (context) => EmployeeListCubit(),
      child: BlocBuilder<EmployeeListCubit, EmployeeListState>(
        builder: (context, state) {
          if (_cubit == null) {
            _cubit = BlocProvider.of<EmployeeListCubit>(context);
          }

          if (_size == null) {
            _size = MediaQuery.of(context).size;
          }

          switch (state.type) {
            case EmployeeListStateType.LOADED: {
              _employeeList = state.data!;

              return _getLoadedWidget();
            }

            case EmployeeListStateType.LOADING: {
              _cubit!.getEmployeeList();

              return Container();
            }
          }
        },
      )
    );
  }

  Widget _getLoadedWidget() {
    return Container(
      height: _size!.height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(),
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitle(title: 'Список сотрудников'),
          Container(
              height: 500,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid
                )
              ),
              margin: EdgeInsets.only(top: 10),
              child: _getListWidget()
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    await EmployeeRepository().fillTable();
                  },
                  child: Icon(Icons.add),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 10
                  ),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    _cubit!.refresh();
                  },
                  child: Icon(Icons.wifi_protected_setup_rounded),
                )
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _getEmployeeListWidget() {
    return ListView.separated(
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return Container(
            child: Text(_employeeList![index].name),
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
    return (_employeeList != null && _employeeList!.isNotEmpty) ?
      _getEmployeeListWidget() :
      _getEmptyListOfWidgets()
    ;
  }

}
