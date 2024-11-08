import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/toasts.dart';
import 'package:org_connect_pt/helpers/api_validation_helper.dart';
import 'package:org_connect_pt/helpers/shared_preference_helper.dart';
import 'package:org_connect_pt/models/api_response.dart';
import 'package:org_connect_pt/models/leave.dart';
import 'package:org_connect_pt/models/pagination.dart';
import 'package:org_connect_pt/screens/login_screen/login_screen.dart';
import 'package:org_connect_pt/services/leave_services.dart';
import 'package:org_connect_pt/utils/constants.dart';

class AllPendingLeavesProvider extends ChangeNotifier {
  bool isLoading = true;
  bool errorOccured = false;
  bool isEmptyList = false;
  String message = '';
  Pagination? paginationDetails;
  int count = 0;

  List<Leave> pendingLeaves = [];

  Future<void> getAllPendingLeaves(BuildContext context) async {
    isLoading = true;
    errorOccured = false;
    isEmptyList = false;
    pendingLeaves = [];
    notifyListeners();

    String authToken = await SharedPreferenceHelper.getAuthToken();

    await LeaveServices.getAllPendingLeaves(authToken).then((result) {
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

  _onSuccess(APIResponse result) {
    try {
      List<Leave> pendingLeavesList = result.data['result'][0]
          .map((leave) => Leave.fromJson(leave))
          .toList()
          .cast<Leave>();

      pendingLeaves.addAll(pendingLeavesList);

      paginationDetails = Pagination.fromJson(result.data['paginationInfo']);

      if (pendingLeaves.isNotEmpty) {
        isLoading = false;
        errorOccured = false;

        if (paginationDetails != null) {
          count = paginationDetails!.totalResults;
        }
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
}
