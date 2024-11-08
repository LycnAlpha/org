import 'package:flutter/material.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class TileItem extends StatelessWidget {
  final String image;
  final String label;
  final onPressed;
  const TileItem({
    super.key,
    required this.image,
    required this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          height: 120,
          width: 120,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 50,
                  width: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(BasicColors.primary).withOpacity(0.2),
                  ),
                  child: Image.asset(image)),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color(BasicColors.primary),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
