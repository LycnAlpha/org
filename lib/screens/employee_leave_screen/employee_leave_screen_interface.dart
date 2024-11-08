import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_providers/leave_types_provider.dart';
import 'package:org_connect_pt/screens/employee_leave_screen/employee_leave_screen_widgets/employee_leave_list.dart';
import 'package:org_connect_pt/screens/employee_leave_screen/employee_leave_screen_widgets/employee_leaves_filter.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class EmployeeLeaveScreenInterface extends StatelessWidget {
  final retry;
  final LeaveTypesProvider leaveTypesProvider;
  const EmployeeLeaveScreenInterface({
    super.key,
    this.retry,
    required this.leaveTypesProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      color: const Color(BasicColors.tertiary),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          EmployeeLeavesFilter(
            leaveTypesProvider: leaveTypesProvider,
          ),
          EmployeeLeaveList(
            retry: retry,
          ),
        ],
      ),
    );
  }
}
