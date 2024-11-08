import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_providers/all_pending_leaves_provider.dart';
import 'package:org_connect_pt/common/common_providers/leave_balance_provider.dart';
import 'package:org_connect_pt/screens/dashboard_screen/dashboard_screen_interface.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreenContent extends StatefulWidget {
  final int permissionLevel;
  const DashboardScreenContent({
    super.key,
    required this.permissionLevel,
  });

  @override
  State<DashboardScreenContent> createState() => _DashboardScreenContentState();
}

class _DashboardScreenContentState extends State<DashboardScreenContent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //refresh();
      getLeaveBalances();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenInterface(
      permissionLevel: widget.permissionLevel,
      retry: getLeaveBalances,
    );
  }

  Future<void> getLeaveBalances() async {
    Provider.of<LeaveBalanceProvider>(
      context,
      listen: false,
    ).getLeaveBalances(context);

    Provider.of<EmployeeListProvider>(
      context,
      listen: false,
    ).getEmployees(context);

    Provider.of<AllPendingLeavesProvider>(
      context,
      listen: false,
    ).getAllPendingLeaves(context);
  }
}
