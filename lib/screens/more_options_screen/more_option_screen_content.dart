import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/more_options_screen/more_option_screen_interface.dart';

class MoreOptionScreenContent extends StatefulWidget {
  final int permissionLevel;
  const MoreOptionScreenContent({
    super.key,
    required this.permissionLevel,
  });

  @override
  State<MoreOptionScreenContent> createState() =>
      _MoreOptionScreenContentState();
}

class _MoreOptionScreenContentState extends State<MoreOptionScreenContent> {
  bool isList = false;
  bool isPersonal = false;
  @override
  Widget build(BuildContext context) {
    return MoreOptionScreenInterface(
      permissionLevel: widget.permissionLevel,
      isList: isList,
      onToggleButtonClicked: setIsList,
      isPersonal: isPersonal,
      onTypeChanged: setIsPersonal,
    );
  }

  void setIsList() {
    setState(() {
      isList = !isList;
    });
  }

  void setIsPersonal() {
    setState(() {
      isPersonal = !isPersonal;
    });
  }
}
