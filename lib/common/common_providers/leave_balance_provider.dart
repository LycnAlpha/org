import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/toasts.dart';
import 'package:org_connect_pt/helpers/api_validation_helper.dart';
import 'package:org_connect_pt/helpers/shared_preference_helper.dart';
import 'package:org_connect_pt/models/api_response.dart';
import 'package:org_connect_pt/models/leave_balance.dart';
import 'package:org_connect_pt/screens/login_screen/login_screen.dart';
import 'package:org_connect_pt/services/leave_services.dart';
import 'package:org_connect_pt/utils/constants.dart';

class LeaveBalanceProvider extends ChangeNotifier {
  bool isLoading = true;
  bool errorOccured = false;
  bool isEmptyList = false;
  String message = '';

  List<LeaveBalance> leaveBalances = [];
  List<LeaveBalance> leaveTypesForFilter = [];

  Future<void> getLeaveBalances(BuildContext context) async {
    isLoading = true;
    errorOccured = false;
    isEmptyList = false;
    leaveBalances = [];
    leaveTypesForFilter = [];
    notifyListeners();

    String authToken = await SharedPreferenceHelper.getAuthToken();

    await LeaveServices.getLeaveBalances(authToken, 82).then((result) {
      try {
        if (result != null) {
          if (result is String) {
            _onFailed(result);
          } else if (result is int) {
            _sessionExpired(context);
          } else {
            //success
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

  _onSuccess(APIResponse response) {
    try {
      List<LeaveBalance> leaveBalanceList = response.data['result']
          .map((leaveBalance) => LeaveBalance.fromJson(leaveBalance))
          .toList()
          .cast<LeaveBalance>();

      leaveBalances.addAll(leaveBalanceList);

      if (leaveBalances.isNotEmpty) {
        leaveTypesForFilter.add(
          LeaveBalance(
              id: 0,
              leavetypeName: 'None',
              balanceCount: 0,
              holdCount: 0,
              entitledCount: 0),
        );
        leaveTypesForFilter.addAll(leaveBalances);

        isLoading = false;
        errorOccured = false;
        notifyListeners();
      } else {
        isEmptyList = true;
        _onFailed('No records available');
      }
    } catch (e) {
      _onFailed(getErrorMessage(Constants.unknownException));
    }
  }

  _onFailed(String message) {
    isLoading = false;
    this.message = message;
    errorOccured = true;
    notifyListeners();
  }

  _sessionExpired(BuildContext context) {
    _onFailed('Session Expired');
    Toasts.showErrorToast('Session Expired');
    openLoginScreen(context);
  }

  openLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  double getTotalLeaveBalance() {
    double tot = 0;

    for (LeaveBalance balance in leaveBalances) {
      tot = tot + (balance.balanceCount - balance.holdCount);
    }

    return tot;
  }

  double getTotalEntitledLeaveCount() {
    double tot = 0;

    for (LeaveBalance balance in leaveBalances) {
      tot = tot + (balance.entitledCount);
    }

    return tot;
  }
}
