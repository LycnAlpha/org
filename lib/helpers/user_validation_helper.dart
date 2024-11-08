import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/toasts.dart';
import 'package:org_connect_pt/helpers/api_validation_helper.dart';
import 'package:org_connect_pt/helpers/shared_preference_helper.dart';
import 'package:org_connect_pt/models/api_response.dart';
import 'package:org_connect_pt/screens/landing_page/landing_page.dart';
import 'package:org_connect_pt/screens/login_screen/login_screen.dart';
import 'package:org_connect_pt/services/authentication_services.dart';
import 'package:org_connect_pt/utils/constants.dart';

validateUserStatus(BuildContext context) async {
  String authToken = await SharedPreferenceHelper.getAuthToken();
  String refreshToken = await SharedPreferenceHelper.getRefreshToken();

  if (authToken.isNotEmpty && refreshToken.isNotEmpty) {
    getUserPermissions(authToken, context);
  } else {
    openLoginScreen(context);
  }
}

Future<void> getUserPermissions(String authToken, BuildContext context) async {
  await AuthenticationServices.getUserPermissions(authToken).then((result) {
    try {
      if (result != null) {
        if (result is String) {
          _onFailed(result, context);
        } else if (result is int) {
          _onFailed('Session Expired', context);
        } else {
          _onSuccess(context, result);
        }
      } else {
        _onFailed(getErrorMessage(Constants.nullException), context);
      }
    } catch (e) {
      _onFailed(getErrorMessage(Constants.unknownException), context);
    }
  }, onError: (errorCode) {
    _onFailed(getErrorMessage(errorCode), context);
  });
}

_onSuccess(BuildContext context, APIResponse result) {
  Toasts.showSuccessToast(result.message ?? 'Success');
  openLandingPage(context);
}

_onFailed(String message, BuildContext context) {
  Toasts.showErrorToast(message);
  openLoginScreen(context);
}

openLandingPage(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const LandingPage(),
    ),
  );
}

openLoginScreen(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ),
  );
}
