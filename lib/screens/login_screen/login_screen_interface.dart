import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/login_screen/login_form.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class LoginScreenInterface extends StatelessWidget {
  final loginFormKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool passwordVisibility;
  final changePasswordVisibility;
  final onForgetPasswordButtonPressed;
  final onSignInButtonPressed;
  final bool isRemeberMeClicked;
  final onRemeberMeClicked;

  const LoginScreenInterface({
    super.key,
    this.loginFormKey,
    required this.usernameController,
    required this.passwordController,
    required this.passwordVisibility,
    this.changePasswordVisibility,
    this.onForgetPasswordButtonPressed,
    this.onSignInButtonPressed,
    required this.isRemeberMeClicked,
    this.onRemeberMeClicked,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scrollbar(
        thickness: 8.0,
        radius: const Radius.circular(4.0),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/image_login_background.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/image_logo_orgConnect_white.png',
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.centerRight,
                    child: FloatingActionButton(
                      shape: const CircleBorder(),
                      onPressed: () async {
                        //TODO: reset QR
                      },
                      backgroundColor: const Color(BasicColors.secondary),
                      child: const Icon(
                        Icons.qr_code,
                        color: Color(BasicColors.tertiary),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    LoginForm(
                      loginFormKey: loginFormKey,
                      usernameController: usernameController,
                      passwordController: passwordController,
                      isPasswordVisible: passwordVisibility,
                      changePasswordVisibility: changePasswordVisibility,
                      onForgetPasswordButtonPressed:
                          onForgetPasswordButtonPressed,
                      onSignInButtonPressed: onSignInButtonPressed,
                      isRemeberMeClicked: isRemeberMeClicked,
                      onRemeberMeClicked: onRemeberMeClicked,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.23,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Image.asset(
                      'assets/images/image_login_bottom_background.png',
                      fit: BoxFit.fitWidth,
                    ),
                    copyRightText(DateTime.now().year),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget copyRightText(int currentYear) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10.0,
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

  List<Shadow> textShadows() {
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
