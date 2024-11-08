import 'package:flutter/material.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class ToggleButton extends StatelessWidget {
  final bool isList;
  final onToggleButtonClicked;
  const ToggleButton({
    super.key,
    required this.isList,
    this.onToggleButtonClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(BasicColors.tertiary),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(0, 0),
                blurRadius: 7,
                spreadRadius: 2,
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (isList) {
                      onToggleButtonClicked();
                    }
                  },
                  child: Icon(
                    Icons.laptop,
                    color: isList
                        ? Colors.grey.shade300
                        : const Color(BasicColors.primary),
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey.shade300,
                  thickness: 2.0,
                ),
                GestureDetector(
                  onTap: () {
                    if (!isList) {
                      onToggleButtonClicked();
                    }
                  },
                  child: Icon(
                    Icons.list_outlined,
                    color: isList
                        ? const Color(BasicColors.primary)
                        : Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
