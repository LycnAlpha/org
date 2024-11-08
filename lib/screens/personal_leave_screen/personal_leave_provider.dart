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

class PersonalLeaveProvider extends ChangeNotifier {
  bool isLoading = true;
  bool errorOccured = false;
  bool isEmptyList = false;
  String message = '';

  bool hasMorePages = false;
  Pagination? paginationDetails;

  List<Leave> personalLeaves = [];

  void getPersonalLeaves(BuildContext context) {
    isLoading = true;
    errorOccured = false;
    isEmptyList = false;
    personalLeaves = [];
    hasMorePages = false;
    notifyListeners();

    _apiCall(context, 1);
  }

  void getMoreLeaves(BuildContext context) {
    if (hasMorePages) {
      _apiCall(context, paginationDetails!.currentPage + 1);
    }
  }

  Future<void> _apiCall(BuildContext context, int page) async {
    String authToken = await SharedPreferenceHelper.getAuthToken();

    await LeaveServices.getPersonalLeaves(authToken, page).then((result) {
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
      List<Leave> personalLeaveList = result.data['result'][0]
          .map((leave) => Leave.fromJson(leave))
          .toList()
          .cast<Leave>();

      personalLeaves.addAll(personalLeaveList);
      paginationDetails = Pagination.fromJson(result.data['paginationInfo']);
      if (personalLeaves.isNotEmpty) {
        isLoading = false;
        errorOccured = false;
        if (paginationDetails != null &&
            paginationDetails!.totalPages != paginationDetails!.currentPage) {
          hasMorePages = true;
        } else {
          hasMorePages = false;
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
