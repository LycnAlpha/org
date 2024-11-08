import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class LoadingScreenInterface extends StatelessWidget {
  const LoadingScreenInterface({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          applicationName(),
          const SizedBox(
            height: 10.0,
          ),
          SpinKitFadingCircle(
            size: MediaQuery.of(context).size.width / 6,
            color: const Color(BasicColors.secondary),
          )
        ],
      )),
    );
  }

  Widget applicationName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Org',
          style: applicationNameTextStyle(BasicColors.primary),
        ),
        Text(
          'C',
          style: applicationNameTextStyle(BasicColors.secondary),
        ),
        Text(
          'onnect',
          style: applicationNameTextStyle(BasicColors.primary),
        )
      ],
    );
  }

  TextStyle applicationNameTextStyle(int color) {
    return TextStyle(
      fontSize: 40.0,
      height: 1.0,
      color: Color(color),
      wordSpacing: 0.20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      shadows: applicationNameTextShadow(),
    );
  }

  List<Shadow> applicationNameTextShadow() {
    return <Shadow>[
      const Shadow(
        offset: Offset(2.0, 2.0),
        color: Color(BasicColors.tertiary),
      ),
      const Shadow(
        offset: Offset(2.0, -2.0),
        color: Color(BasicColors.tertiary),
      ),
      const Shadow(
        offset: Offset(-2.0, 2.0),
        color: Color(BasicColors.tertiary),
      ),
      const Shadow(
        offset: Offset(-2.0, -2.0),
        color: Color(BasicColors.tertiary),
      ),
    ];
  }
}
