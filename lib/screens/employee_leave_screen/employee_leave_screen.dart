import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_providers/leave_types_provider.dart';
import 'package:org_connect_pt/screens/employee_leave_screen/employee_leave_provider.dart';
import 'package:org_connect_pt/screens/employee_leave_screen/employee_leave_screen_content.dart';
import 'package:provider/provider.dart';

class EmployeeLeaveScreen extends StatelessWidget {
  const EmployeeLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => EmployeeLeaveProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LeaveTypesProvider(),
      ),
    ], child: const EmployeeLeaveScreenContent());
  }
}
