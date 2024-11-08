import 'package:flutter/material.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  const CustomBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(BasicColors.secondary)),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
