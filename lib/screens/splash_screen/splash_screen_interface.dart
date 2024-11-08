import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class SplashScreenInterface extends StatelessWidget {
  const SplashScreenInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 10.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(150, 150),
                    bottomRight: Radius.elliptical(150, 150)),
                color: Color(BasicColors.primary),
              ),
              child: Image.asset(
                'assets/images/image_logo_orgConnect_white.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            const SpinKitFadingCube(
              color: Color(BasicColors.primary),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            copyRightText(DateTime.now().year),
            const Text(
              'Version: 1.0.0',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget copyRightText(int currentYear) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5.0,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
          children: [
            const TextSpan(
              text: 'Designed & Developed by ',
            ),
            const TextSpan(
              text: 'ICP Technologies. ',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xff61A901),
              ),
            ),
            TextSpan(
              text: '\n$currentYear © All rights reserved.',
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
