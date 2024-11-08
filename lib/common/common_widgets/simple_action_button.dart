import 'package:flutter/material.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class SimpleActionButton extends StatelessWidget {
  final String displayText;
  final Color color;
  final icon;
  final onPressed;

  const SimpleActionButton(
      {super.key,
      required this.displayText,
      required this.color,
      this.onPressed,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: icon != null,
              child: Icon(
                icon,
                color: const Color(BasicColors.tertiary),
              ),
            ),
            Visibility(
              visible: icon != null,
              child: const SizedBox(
                width: 20.0,
              ),
            ),
            Text(
              displayText,
              style: const TextStyle(
                fontSize: 16.0,
                color: Color(BasicColors.tertiary),
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
