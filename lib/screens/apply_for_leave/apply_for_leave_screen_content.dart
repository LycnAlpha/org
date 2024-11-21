import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:org_connect_pt/common/common_dialogs/apply_leave_confirmation_dialog.dart';
import 'package:org_connect_pt/common/common_providers/leave_balance_provider.dart';
import 'package:org_connect_pt/models/leave.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_interface.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/apply_for_leave_data_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/backup_employees_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/holidays_provider.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';

class ApplyForLeaveScreenContent extends StatefulWidget {
  const ApplyForLeaveScreenContent({super.key});

  @override
  State<ApplyForLeaveScreenContent> createState() =>
      _ApplyForLeaveScreenContentState();
}

class _ApplyForLeaveScreenContentState
    extends State<ApplyForLeaveScreenContent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //refresh();
      getMasterData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Apply for Leave',
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
        child: ApplyForLeaveScreenInterface(
          applyLeave: applyLeave,
        ),
      ),
    );
  }

  Future<void> getMasterData() async {
    Provider.of<BackupEmployeesProvider>(
      context,
      listen: false,
    ).getBackupEmployees(context);

    Provider.of<LeaveBalanceProvider>(
      context,
      listen: false,
    ).getLeaveBalances(context);

    Provider.of<HolidaysProvider>(
      context,
      listen: false,
    ).getHolidays(context);
  }

  applyLeave() async {
    final applyForLeaveDataProvider = Provider.of<ApplyForLeaveDataProvider>(
      context,
      listen: false,
    );

    showDialog(
      context: context,
      builder: (ctx) => ApplyLeaveConfirmationDialog(
          leave: Leave(
              leaveId: 0,
              employeeId: 82,
              employeeName: '',
              startDate: DateFormat('yyyy-MM-dd')
                  .format(applyForLeaveDataProvider.selectedFromDate!),
              endDate: DateFormat('yyyy-MM-dd')
                  .format(applyForLeaveDataProvider.selectedToDate!),
              startSegment: applyForLeaveDataProvider.selectedFromSegment,
              endSegment: applyForLeaveDataProvider.selectedToSegment,
              statusId: 10,
              statusDescription: '',
              reason: applyForLeaveDataProvider.reason,
              backupEmployeeId:
                  applyForLeaveDataProvider.selectedActingArrangement != null
                      ? applyForLeaveDataProvider.selectedActingArrangement!.id
                      : 0,
              backupEmployeeName: '',
              contactNumber: applyForLeaveDataProvider.enteredContactNumber,
              leaveTypeId: applyForLeaveDataProvider.selectedLeaveType!.id,
              dayCount: applyForLeaveDataProvider.calculatedLeaveCount)),
    );
  }
}
