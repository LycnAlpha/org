import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_provider.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_screen_interface.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';

class EmployeeListScreenContent extends StatefulWidget {
  const EmployeeListScreenContent({super.key});

  @override
  State<EmployeeListScreenContent> createState() =>
      _EmployeeListScreenContentState();
}

class _EmployeeListScreenContentState extends State<EmployeeListScreenContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getEmployees();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(BasicColors.primary),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(BasicColors.tertiary),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Employee Profile',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: Color(BasicColors.tertiary),
          ),
        ),
      ),
      body: SafeArea(
        child: EmployeeListScreenInterface(
          refresh: getEmployees,
        ),
      ),
    );
  }

  Future<void> getEmployees() async {
    Provider.of<EmployeeListProvider>(
      context,
      listen: false,
    ).getEmployees(context);
  }
}
