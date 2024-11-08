import 'package:flutter/material.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class CountCard extends StatelessWidget {
  final String image;
  final String label;
  final int value;
  final color;
  const CountCard({
    super.key,
    required this.image,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.11,
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(BasicColors.tertiary),
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    value.toString().length == 1
                        ? '00$value'
                        : value.toString().length == 2
                            ? '0$value'
                            : '$value',
                    style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w800,
                        color: color),
                  ),
                ),
                Expanded(child: Image.asset(image)),
                Icon(
                  Icons.more_vert,
                  color: Colors.grey.shade300,
                )
              ],
            ),
            Text(
              label,
              style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  color: Color(BasicColors.primary)),
            ),
          ],
        ),
      ),
    );
  }
}
