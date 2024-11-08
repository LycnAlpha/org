import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_providers/all_pending_leaves_provider.dart';
import 'package:org_connect_pt/common/common_providers/leave_balance_provider.dart';
import 'package:org_connect_pt/screens/dashboard_screen/dashboard_screen_content.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_provider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  final int permissionLevel;
  const DashboardScreen({
    super.key,
    required this.permissionLevel,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LeaveBalanceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EmployeeListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AllPendingLeavesProvider(),
        ),
      ],
      child: DashboardScreenContent(
        permissionLevel: permissionLevel,
      ),
    );
  }
}
