import 'package:flutter/material.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class ListItem extends StatelessWidget {
  final String image;
  final String label;
  final onPressed;
  const ListItem({
    super.key,
    required this.image,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(BasicColors.tertiary),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(0, 0),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 40,
                  width: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(BasicColors.primary).withOpacity(0.2),
                  ),
                  child: Image.asset(image)),
              const SizedBox(
                width: 20.0,
              ),
              Text(
                label,
                style: const TextStyle(
                    color: Color(BasicColors.primary),
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600),
              ),
              const Expanded(child: SizedBox()),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(BasicColors.primary),
              )
            ],
          ),
        ),
      ),
    );
  }
}
