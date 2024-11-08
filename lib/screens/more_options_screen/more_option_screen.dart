import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/more_options_screen/more_option_screen_content.dart';

class MoreOptionScreen extends StatelessWidget {
  final int permissionLevel;
  const MoreOptionScreen({
    super.key,
    required this.permissionLevel,
  });

  @override
  Widget build(BuildContext context) {
    return MoreOptionScreenContent(
      permissionLevel: permissionLevel,
    );
  }
}
