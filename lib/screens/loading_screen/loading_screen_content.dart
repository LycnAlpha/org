import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/landing_page/landing_page.dart';
import 'package:org_connect_pt/screens/loading_screen/loading_screen_interface.dart';

class LoadingScreenContent extends StatefulWidget {
  const LoadingScreenContent({super.key});

  @override
  State<LoadingScreenContent> createState() => _LoadingScreenContentState();
}

class _LoadingScreenContentState extends State<LoadingScreenContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // validateUserStatus(context);
      _addDelay();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const LoadingScreenInterface();
  }

  _addDelay() async {
    Future.delayed(const Duration(seconds: 3), () {
      _openLandingPage();
    });
  }

  _openLandingPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LandingPage(),
      ),
    );
  }
}
