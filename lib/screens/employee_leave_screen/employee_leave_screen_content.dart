import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_providers/leave_types_provider.dart';
import 'package:org_connect_pt/screens/employee_leave_screen/employee_leave_provider.dart';
import 'package:org_connect_pt/screens/employee_leave_screen/employee_leave_screen_interface.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';

class EmployeeLeaveScreenContent extends StatefulWidget {
  const EmployeeLeaveScreenContent({super.key});

  @override
  State<EmployeeLeaveScreenContent> createState() =>
      _EmployeeLeaveScreenContentState();
}

class _EmployeeLeaveScreenContentState
    extends State<EmployeeLeaveScreenContent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //refresh();
      getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leave Management',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: Color(0xff1C577D),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(BasicColors.tertiary),
      ),
      backgroundColor: const Color(BasicColors.tertiary),
      body: SafeArea(
        child: EmployeeLeaveScreenInterface(
          retry: getData,
          leaveTypesProvider: Provider.of<LeaveTypesProvider>(
            context,
            listen: false,
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    Provider.of<EmployeeLeaveProvider>(
      context,
      listen: false,
    ).getEmployeeLeaves(context);

    Provider.of<LeaveTypesProvider>(
      context,
      listen: false,
    ).getLeaveBalances(context);
  }
}
