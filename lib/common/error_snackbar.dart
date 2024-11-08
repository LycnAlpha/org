import 'package:flutter/material.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class ErrorSnackBar {
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
              color: Color(BasicColors.tertiary), fontSize: 16.0),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
        showCloseIcon: true,
      ),
    );
  }
}
