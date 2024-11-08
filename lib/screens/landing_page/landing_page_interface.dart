import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/calendar_screen/calendar_screen.dart';
import 'package:org_connect_pt/screens/dashboard_screen/dashboard_screen.dart';
import 'package:org_connect_pt/screens/landing_page/bottom_navigation_provider.dart';
import 'package:org_connect_pt/screens/more_options_screen/more_option_screen.dart';
import 'package:org_connect_pt/screens/my_profile_screen/my_profile_screen.dart';
import 'package:org_connect_pt/utils/constants.dart';
import 'package:provider/provider.dart';

class LandingPageInterface extends StatelessWidget {
  final int permissionLevel;
  const LandingPageInterface({
    super.key,
    required this.permissionLevel,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<BottomNavigationProvider>(
      builder: (context, bottomNavigationProvider, child) {
        return bottomNavigationProvider.selectedScreen ==
                Constants.dashboardScreen
            ? DashboardScreen(
                permissionLevel: permissionLevel) //dashboard screen
            : bottomNavigationProvider.selectedScreen ==
                    Constants.calendarScreen
                ? const CalendarScreen() //calendar screen
                : bottomNavigationProvider.selectedScreen ==
                        Constants.myProfileScreen
                    ? const MyProfileScreen() //my profile screen
                    : MoreOptionScreen(
                        permissionLevel: permissionLevel,
                      ); // more screen
      },
    ));
  }
}
