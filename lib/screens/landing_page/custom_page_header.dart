import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_dialogs/logout_confirmation_dialog.dart';
import 'package:org_connect_pt/screens/landing_page/bottom_navigation_provider.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:org_connect_pt/utils/constants.dart';
import 'package:provider/provider.dart';

class CustomPageHeader extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  const CustomPageHeader({
    super.key,
    required this.username,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Consumer<BottomNavigationProvider>(
          builder: (context, bottomNavigationProvider, child) {
        return Text(
          bottomNavigationProvider.selectedScreen == Constants.dashboardScreen
              ? Constants.dashboard
              //Constants.home
              : bottomNavigationProvider.selectedScreen ==
                      Constants.calendarScreen
                  ? Constants.calendar
                  : bottomNavigationProvider.selectedScreen ==
                          Constants.myProfileScreen
                      ? Constants.myProfile
                      : Constants.more,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: Color(BasicColors.primary),
          ),
        );
      }),
      leading: Padding(
        padding: const EdgeInsets.only(left: 5.0, top: 2, bottom: 2),
        child: Image.asset(
          'assets/images/image_header.png',
        ),
      ),
      centerTitle: true,
      backgroundColor: Color(BasicColors.tertiary),
      actions: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: PopupMenuButton(
                elevation: 10.0,
                color: Color(BasicColors.tertiary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                onSelected: (value) {
                  if (value == 'logout') {
                    showDialog(
                      context: context,
                      builder: (ctx) => const LogoutConfirmationDialog(),
                    );
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 'username',
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          username,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(BasicColors.primary)),
                        ),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'logout',
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Log Out",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(BasicColors.primary)),
                        ),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'app_version',
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Version: ${Constants.applicationVersion}',
                          style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w300,
                              color: Color(BasicColors.primary)),
                        ),
                      ),
                    ),
                  ];
                },
                child: SizedBox(
                    height: 35.0,
                    width: 35.0,
                    child:
                        Image.asset('assets/icons/icon_notifications_on.png'))))
      ],
    );
  }
}
