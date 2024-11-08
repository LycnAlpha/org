import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/more_options_screen/more_option_screen_widgets/more_option_screen_employee.dart';
import 'package:org_connect_pt/screens/more_options_screen/more_option_screen_widgets/more_option_screen_supervisor.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:org_connect_pt/utils/constants.dart';

class MoreOptionScreenInterface extends StatelessWidget {
  final int permissionLevel;
  final bool isList;
  final onToggleButtonClicked;
  final bool isPersonal;
  final onTypeChanged;

  const MoreOptionScreenInterface({
    super.key,
    required this.permissionLevel,
    required this.isList,
    this.onToggleButtonClicked,
    required this.isPersonal,
    this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return permissionLevel == Constants.permissionLevelNone
        ? const Center(
            child: Text(
              'You do not have required permission to access this content!',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(BasicColors.primary),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          )
        : permissionLevel == Constants.permissionLevelEmployee
            ? MoreOptionScreenEmployee(
                isList: isList,
                onToggleButtonClicked: onToggleButtonClicked,
              )
            : MoreOptionScreenSupervisor(
                isList: isList,
                isPersonal: isPersonal,
                onToggleButtonClicked: onToggleButtonClicked,
                onTypeChanged: onTypeChanged,
              );
  }
}
