import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_providers/leave_balance_provider.dart';
import 'package:org_connect_pt/screens/personal_leave_screen/personal_leave_screen_content.dart';
import 'package:org_connect_pt/screens/personal_leave_screen/personal_leave_provider.dart';
import 'package:provider/provider.dart';

class PersonalLeaveScreen extends StatelessWidget {
  const PersonalLeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LeaveBalanceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PersonalLeaveProvider(),
        ),
      ],
      child: const PersonalLeaveScreenContent(),
    );
  }
}
