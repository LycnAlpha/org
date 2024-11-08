import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_dialogs/disable_user_interface_dialog.dart';
import 'package:org_connect_pt/common/error_snackbar.dart';
import 'package:org_connect_pt/common/toasts.dart';
import 'package:org_connect_pt/helpers/shared_preference_helper.dart';
import 'package:org_connect_pt/helpers/api_validation_helper.dart';
import 'package:org_connect_pt/models/api_response.dart';
import 'package:org_connect_pt/screens/loading_screen/loading_screen.dart';
import 'package:org_connect_pt/screens/login_screen/login_screen_interface.dart';
import 'package:org_connect_pt/services/authentication_services.dart';
import 'package:org_connect_pt/utils/constants.dart';

class LoginScreenContent extends StatefulWidget {
  const LoginScreenContent({super.key});

  @override
  State<LoginScreenContent> createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<LoginScreenContent> {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool passwordVisibility = false;
  bool isRemeberMeClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreenInterface(
        loginFormKey: loginFormKey,
        usernameController: usernameController,
        passwordController: passwordController,
        passwordVisibility: passwordVisibility,
        changePasswordVisibility: changePasswordVisibility,
        onForgetPasswordButtonPressed: openForgetPasswordScreen,
        onSignInButtonPressed: validateUserInput,
        isRemeberMeClicked: isRemeberMeClicked,
        onRemeberMeClicked: changeRemeberMe,
      ),
    );
  }

  changePasswordVisibility() {
    setState(() {
      passwordVisibility = !passwordVisibility;
    });
  }

  changeRemeberMe() {
    setState(() {
      isRemeberMeClicked = !isRemeberMeClicked;
    });
  }

  openForgetPasswordScreen() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.focusedChild?.unfocus();
    }
    //TODO: implement navigating to forget password screen
  }

  validateUserInput() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.focusedChild?.unfocus();
    }

    if (passwordController.text.trim().isEmpty ||
        usernameController.text.trim().isEmpty) {
      ErrorSnackBar.showErrorSnackBar(
          context, 'Please fill out all the fields');
    } else {
      // _login(usernameController.text.trim(), passwordController.text.trim());
      if (passwordController.text == '1234') {
        if (usernameController.text.trim().toLowerCase() ==
            'employee@icp.com') {
          SharedPreferenceHelper.savePermissionLevel(
              Constants.permissionLevelEmployee);
          _openLoadingScreen();
        } else if (usernameController.text.trim().toLowerCase() ==
            'supervisor@icp.com') {
          SharedPreferenceHelper.savePermissionLevel(
              Constants.permissionLevelSupervisor);
          _openLoadingScreen();
        } else if (usernameController.text.trim().toLowerCase() ==
            'hradmin@icp.com') {
          SharedPreferenceHelper.savePermissionLevel(
              Constants.permissionLevelHRAdmin);
          _openLoadingScreen();
        } else if (usernameController.text.trim().toLowerCase() ==
            'hrhod@icp.com') {
          SharedPreferenceHelper.savePermissionLevel(
              Constants.permissionLevelHRHOD);
          _openLoadingScreen();
        } else {
          SharedPreferenceHelper.savePermissionLevel(
              Constants.permissionLevelNone);
          _loginFailed('Invalid credentials');
        }
      } else {
        _loginFailed('Invalid credentials');
      }
    }

    /*   if (loginFormKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (ctx) => const DisableUserInteractionDialog(),
      );

      if (passwordController.text == '1234') {
        if (usernameController.text.trim().toLowerCase() ==
            'employee@icp.com') {
          SharedPreferenceHelper.savePermissionLevel(
              Constants.permissionLevelEmployee);
          _openLoadingScreen();
        } else if (usernameController.text.trim().toLowerCase() ==
            'supervisor@icp.com') {
          SharedPreferenceHelper.savePermissionLevel(
              Constants.permissionLevelSupervisor);
          _openLoadingScreen();
        } else if (usernameController.text.trim().toLowerCase() ==
            'hradmin@icp.com') {
          SharedPreferenceHelper.savePermissionLevel(
              Constants.permissionLevelHRAdmin);
          _openLoadingScreen();
        } else if (usernameController.text.trim().toLowerCase() ==
            'hrhod@icp.com') {
          SharedPreferenceHelper.savePermissionLevel(
              Constants.permissionLevelHRHOD);
          _openLoadingScreen();
        } else {
          SharedPreferenceHelper.savePermissionLevel(
              Constants.permissionLevelNone);
          _loginFailed('Invalid credentials');
        }
      } else {
        _loginFailed('Invalid credentials');
      }

      // _login(usernameController.text.toLowerCase(), passwordController.text);
    }*/
  }

  _login(String username, String password) async {
    showDialog(
      context: context,
      builder: (ctx) => const DisableUserInteractionDialog(),
    );

    await AuthenticationServices.login(username, password).then((result) {
      try {
        if (result != null) {
          if (result is String) {
            _loginFailed(result);
          } else {
            _loginSuccess(result);
          }
        } else {
          _loginFailed(getErrorMessage(Constants.nullException));
        }
      } catch (e) {
        _loginFailed(getErrorMessage(Constants.unknownException));
      }
    }, onError: (errorCode) {
      _loginFailed(getErrorMessage(errorCode));
    });
  }

  _loginSuccess(APIResponse response) {
    String authToken = response.data['access_token'] ?? '';
    String refreshToken = response.data['refresh_token'] ?? '';

    if (authToken.isNotEmpty && refreshToken.isNotEmpty) {
      SharedPreferenceHelper.saveAuthToken(authToken);
      SharedPreferenceHelper.saverRefreshToken(refreshToken);
      SharedPreferenceHelper.savePermissionLevel(
          Constants.permissionLevelHRHOD);

      Toasts.showSuccessToast(response.message ?? 'Success');

      Navigator.pop(context);
      _openLoadingScreen();
    } else {
      _loginFailed(
          'Error occured while processing the request. Please contact Cupport');
    }
  }

  _loginFailed(String message) {
    Navigator.pop(context);
    ErrorSnackBar.showErrorSnackBar(context, message);
  }

  _openLoadingScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoadingScreen(),
      ),
    );
  }
}
