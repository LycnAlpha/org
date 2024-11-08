import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/landing_page/bottom_navigation_provider.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:org_connect_pt/utils/constants.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
        builder: (context, bottomNavigationProvider, child) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          boxShadow: [
            /*   BoxShadow(
                  color: Colors.greenAccent,
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ), */ //BoxShadow
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(0, 0),
              blurRadius: 2,
              spreadRadius: 1,
            ), //BoxShadow
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          child: BottomNavigationBar(
            backgroundColor: Color(BasicColors.tertiary),
            type: BottomNavigationBarType.fixed,
            fixedColor: const Color(BasicColors.secondary),
            unselectedItemColor: const Color(BasicColors.primary),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12.0,
              color: Color(BasicColors.primary),
            ),
            selectedLabelStyle: const TextStyle(
              fontSize: 12.0,
              color: Color(BasicColors.secondary),
            ),
            onTap: (index) {
              bottomNavigationProvider.setSelectedScreen(index);
            },
            currentIndex: bottomNavigationProvider.selectedScreen,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 15,
                    child: Image.asset(
                      'assets/icons/icon_dashboard.png',
                      color: bottomNavigationProvider.selectedScreen ==
                              Constants.dashboardScreen
                          ? const Color(BasicColors.secondary)
                          : const Color(BasicColors.primary),
                    ),
                  ),
                ),
                label: Constants.dashboard,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 15,
                    child: Image.asset(
                      'assets/icons/icon_calendar.png',
                      color: bottomNavigationProvider.selectedScreen ==
                              Constants.calendarScreen
                          ? const Color(BasicColors.secondary)
                          : const Color(BasicColors.primary),
                    ),
                  ),
                ),
                label: Constants.calendar,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 15,
                    child: Image.asset(
                      'assets/icons/icon_my_profile.png',
                      color: bottomNavigationProvider.selectedScreen ==
                              Constants.myProfileScreen
                          ? const Color(BasicColors.secondary)
                          : const Color(BasicColors.primary),
                    ),
                  ),
                ),
                label: 'My Profile',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 15,
                    child: Image.asset(
                      'assets/icons/icon_more.png',
                      color: bottomNavigationProvider.selectedScreen ==
                              Constants.moreScreen
                          ? const Color(BasicColors.secondary)
                          : const Color(BasicColors.primary),
                    ),
                  ),
                ),
                label: Constants.more,
              ),
            ],
          ),
        ),
      );
    });
  }
}
