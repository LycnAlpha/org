import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_providers/leave_balance_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/apply_for_leave_data_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_content.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/backup_employees_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/holidays_provider.dart';
import 'package:provider/provider.dart';

class ApplyForLeaveScreen extends StatelessWidget {
  const ApplyForLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ApplyForLeaveDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BackupEmployeesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LeaveBalanceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HolidaysProvider(),
        ),
      ],
      child: const ApplyForLeaveScreenContent(),
    );
  }
}
