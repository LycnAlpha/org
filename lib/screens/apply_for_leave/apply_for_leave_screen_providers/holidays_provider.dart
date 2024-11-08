import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/toasts.dart';
import 'package:org_connect_pt/helpers/api_validation_helper.dart';
import 'package:org_connect_pt/helpers/shared_preference_helper.dart';
import 'package:org_connect_pt/models/api_response.dart';
import 'package:org_connect_pt/models/holiday.dart';
import 'package:org_connect_pt/screens/login_screen/login_screen.dart';
import 'package:org_connect_pt/services/common_services.dart';
import 'package:org_connect_pt/utils/constants.dart';

class HolidaysProvider extends ChangeNotifier {
  bool isLoading = true;
  bool errorOccured = false;
  bool isEmptyList = false;
  String message = '';

  List<Holiday> holidays = [];

  Future<void> getHolidays(BuildContext context) async {
    isLoading = true;
    errorOccured = false;
    isEmptyList = false;
    holidays = [];
    notifyListeners();

    String authToken = await SharedPreferenceHelper.getAuthToken();

    await CommonServices.getAllHolidays(authToken).then((result) {
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
      List<Holiday> holidaysList = result.data['result']
          .map((holiday) => Holiday.fromJson(holiday))
          .toList()
          .cast<Holiday>();

      holidays.addAll(holidaysList);

      if (holidays.isNotEmpty) {
        isLoading = false;
        errorOccured = false;

        notifyListeners();
      } else {
        isEmptyList = true;
        _onFailed('No records available');
        notifyListeners();
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
