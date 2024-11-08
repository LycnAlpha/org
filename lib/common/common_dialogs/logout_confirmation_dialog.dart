import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_dialogs/disable_user_interface_dialog.dart';
import 'package:org_connect_pt/common/common_widgets/simple_action_button.dart';
import 'package:org_connect_pt/common/text_objects.dart';
import 'package:org_connect_pt/screens/login_screen/login_screen.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: dialogBoxTitle(
          'Comeback Soon!',
        ),
        backgroundColor: Color(BasicColors.tertiary),
        titlePadding: const EdgeInsets.all(15.0),
        contentPadding: const EdgeInsets.all(15.0),
        actionsPadding: const EdgeInsets.all(15.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child:
              dialogBoxContent(context, 'Are You Sure You Want to Log Out ?'),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SimpleActionButton(
                  displayText: 'No',
                  color: const Color(BasicColors.primary),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: SimpleActionButton(
                  displayText: 'Yes',
                  color: const Color(BasicColors.secondary),
                  onPressed: () {
                    _logout(context);
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  _logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) => const DisableUserInteractionDialog(),
    );

    SharedPreferences sh = await SharedPreferences.getInstance();

    sh.clear();

    Navigator.pop(context);
    Navigator.pop(context);
    _openLoginScreen(context);
  }

  _openLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}
