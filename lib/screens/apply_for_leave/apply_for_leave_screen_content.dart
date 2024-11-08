import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:org_connect_pt/common/common_dialogs/disable_user_interface_dialog.dart';
import 'package:org_connect_pt/common/common_providers/leave_balance_provider.dart';
import 'package:org_connect_pt/common/error_snackbar.dart';
import 'package:org_connect_pt/common/toasts.dart';
import 'package:org_connect_pt/helpers/api_validation_helper.dart';
import 'package:org_connect_pt/helpers/shared_preference_helper.dart';
import 'package:org_connect_pt/models/api_response.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_interface.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/apply_for_leave_data_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/backup_employees_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/holidays_provider.dart';
import 'package:org_connect_pt/screens/login_screen/login_screen.dart';
import 'package:org_connect_pt/services/leave_services.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:org_connect_pt/utils/constants.dart';
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
      builder: (ctx) => const DisableUserInteractionDialog(),
    );

    String authToken = await SharedPreferenceHelper.getAuthToken();

    await LeaveServices.applyForLeave(
            authToken,
            82,
            DateFormat('yyyy-MM-dd')
                .format(applyForLeaveDataProvider.selectedFromDate!),
            DateFormat('yyyy-MM-dd')
                .format(applyForLeaveDataProvider.selectedToDate!),
            applyForLeaveDataProvider.reason,
            applyForLeaveDataProvider.selectedFromSegment,
            applyForLeaveDataProvider.selectedFromSegment,
            applyForLeaveDataProvider.selectedActingArrangement != null
                ? applyForLeaveDataProvider.selectedActingArrangement!.id
                : 0,
            applyForLeaveDataProvider.enteredContactNumber,
            applyForLeaveDataProvider.selectedLeaveType!.id,
            applyForLeaveDataProvider.calculatedLeaveCount)
        .then((result) {
      try {
        if (result != null) {
          if (result is String) {
            _onFailed(result);
          } else if (result is int) {
            _sessionExpired();
          } else {
            _onSuccess(result);
          }
        } else {
          _onFailed(getErrorMessage(Constants.nullException));
        }
      } catch (e) {
        _onFailed(getErrorMessage(Constants.unknownException));
      }
    }, onError: (errorCode) {
      _onFailed(getErrorMessage(errorCode));
    });
  }

  _onFailed(String message) {
    Navigator.pop(context);
    ErrorSnackBar.showErrorSnackBar(context, message);
  }

  _sessionExpired() {
    Toasts.showErrorToast('Session Expired');
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  _onSuccess(APIResponse response) {
    Toasts.showSuccessToast(response.message ?? 'Success');
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
