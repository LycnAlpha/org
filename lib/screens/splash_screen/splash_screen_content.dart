import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/login_screen/login_screen.dart';
import 'package:org_connect_pt/screens/splash_screen/splash_screen_interface.dart';

class SplashScreenContent extends StatefulWidget {
  const SplashScreenContent({super.key});

  @override
  State<SplashScreenContent> createState() => _SplashScreenContentState();
}

class _SplashScreenContentState extends State<SplashScreenContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addDelay();
      // validateUserStatus(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreenInterface(),
    );
  }

  _addDelay() async {
    Future.delayed(const Duration(seconds: 3), () {
      // _validatePortalStatus();
      // _openPortalConfigurationScreen();
      _openLoginScreen();
      // validateUserStatus(context);
    });
  }

  _openLoginScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}
