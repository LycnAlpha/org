import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class Toasts {
  static void showDetailToast(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        textColor: Colors.black,
        backgroundColor: const Color(BasicColors.tertiary));
  }

  static void showOngoingProcessToast(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        textColor: const Color(BasicColors.tertiary),
        backgroundColor: Colors.orange);
  }

  static void showSuccessToast(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        textColor: const Color(BasicColors.tertiary),
        backgroundColor: Colors.green);
  }

  static void showErrorToast(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
        textColor: const Color(BasicColors.tertiary),
        backgroundColor: Colors.red);
  }
}
