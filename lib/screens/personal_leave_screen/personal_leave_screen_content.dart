import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_providers/leave_balance_provider.dart';
import 'package:org_connect_pt/screens/personal_leave_screen/personal_leave_screen_interface.dart';
import 'package:org_connect_pt/screens/personal_leave_screen/personal_leave_provider.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';

class PersonalLeaveScreenContent extends StatefulWidget {
  const PersonalLeaveScreenContent({super.key});

  @override
  State<PersonalLeaveScreenContent> createState() =>
      _PersonalLeaveScreenContentState();
}

class _PersonalLeaveScreenContentState
    extends State<PersonalLeaveScreenContent> {
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
          'Leave',
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
        child: PersonalLeaveScreenInterface(
          retry: getData,
        ),
      ),
    );
  }

  Future<void> getData() async {
    Provider.of<LeaveBalanceProvider>(
      context,
      listen: false,
    ).getLeaveBalances(context);

    Provider.of<PersonalLeaveProvider>(
      context,
      listen: false,
    ).getPersonalLeaves(context);
  }
}
