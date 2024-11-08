import 'package:flutter/cupertino.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

Widget dialogBoxTitle(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.w700,
      color: Color(BasicColors.primary),
    ),
    textAlign: TextAlign.center,
  );
}

Widget dialogBoxContent(context, String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: const Color(BasicColors.primary).withOpacity(0.60),
    ),
    textAlign: TextAlign.center,
  );
}
