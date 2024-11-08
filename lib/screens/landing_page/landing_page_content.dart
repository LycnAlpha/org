import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:org_connect_pt/helpers/shared_preference_helper.dart';
import 'package:org_connect_pt/screens/landing_page/custom_bottom_navigation_bar.dart';
import 'package:org_connect_pt/screens/landing_page/custom_page_header.dart';
import 'package:org_connect_pt/screens/landing_page/landing_page_interface.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class LandingPageContent extends StatefulWidget {
  const LandingPageContent({super.key});

  @override
  State<LandingPageContent> createState() => _LandingPageContentState();
}

class _LandingPageContentState extends State<LandingPageContent> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: SharedPreferenceHelper.getPermissionLevel(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: SpinKitCircle(
                color: Color(BasicColors.secondary),
                size: 50.0,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text(
                'An error occured. \nPlease contact support',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color(BasicColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
          final permissionLevel = snapshot.data as int;
          return Scaffold(
            appBar: const CustomPageHeader(username: 'Dimal'),
            body: LandingPageInterface(
              permissionLevel: permissionLevel,
            ),
            bottomNavigationBar: const CustomBottomNavigationBar(),
          );
        }
      },
    );
  }
}
