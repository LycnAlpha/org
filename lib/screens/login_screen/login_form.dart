import 'package:flutter/material.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class LoginForm extends StatelessWidget {
  final loginFormKey;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final changePasswordVisibility;
  final onForgetPasswordButtonPressed;
  final onSignInButtonPressed;
  final bool isRemeberMeClicked;
  final onRemeberMeClicked;
  const LoginForm({
    super.key,
    this.loginFormKey,
    required this.usernameController,
    required this.passwordController,
    required this.isPasswordVisible,
    this.changePasswordVisibility,
    this.onForgetPasswordButtonPressed,
    this.onSignInButtonPressed,
    required this.isRemeberMeClicked,
    this.onRemeberMeClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        welcomeMessage(),
        inputIFields(
          loginFormKey,
          usernameController,
          passwordController,
          isPasswordVisible,
          changePasswordVisibility,
        ),
        buttonForgetPassword(onForgetPasswordButtonPressed),
        buttonSignIn(onSignInButtonPressed),
      ],
    );
  }

  Widget welcomeMessage() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome Back',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w900,
              color: const Color(BasicColors.primary),
              height: 1.0,
              letterSpacing: 2.0,
              // wordSpacing: 0.20,
              shadows: textShadows(),
            ),
          ),
          Text('Log in to your account',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                shadows: textShadows(),
              )),
        ],
      ),
    );
  }

  Widget inputIFields(
    loginFormKey,
    usernameController,
    passwordController,
    isPasswordVisible,
    changePasswordVisibility,
  ) {
    return Form(
      key: loginFormKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: AutofillGroup(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            usernameField(usernameController),
            passwordField(
              passwordController,
              isPasswordVisible,
              changePasswordVisibility,
            ),
          ],
        ),
      ),
    );
  }

  Widget usernameField(usernameController) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: Colors.grey.shade400,
            )),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: usernameController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [
                  AutofillHints.email,
                  AutofillHints.username
                ],
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
                /*  validator: (value) {
                  if (value!.isEmpty) {
                    return 'Username is required';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return 'Invalid username';
                  }
                  return null;
                },*/
                cursorColor: const Color(BasicColors.primary),
                decoration: inputFieldDecoration("Enter Username", null),
              ),
            ),
            const Icon(
              Icons.account_circle_outlined,
              color: Color(0xFF8391A1),
              size: 25.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget passwordField(
    passwordController,
    isPasswordVisible,
    changePasswordVisibility,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5.0,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: Colors.grey.shade400,
            )),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                obscureText: !isPasswordVisible,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
                /* validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },*/
                cursorColor: const Color(BasicColors.primary),
                decoration: inputFieldDecoration("Enter Password", null),
              ),
            ),
            buttonShowPassword(isPasswordVisible, changePasswordVisibility),
          ],
        ),
      ),
    );
  }

  Widget buttonShowPassword(
    isPasswordVisible,
    changePasswordVisibility,
  ) {
    return GestureDetector(
      onTap: changePasswordVisibility,
      child: Icon(
        isPasswordVisible
            ? Icons.visibility_outlined
            : Icons.visibility_off_outlined,
        color: const Color(0xFF8391A1),
        size: 25.0,
      ),
    );
  }

  InputDecoration inputFieldDecoration(label, suffix) {
    return InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(fontSize: 15.0, color: Color(0xFF8391A1)),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: const TextStyle(color: Color(0xFF8391A1)),
        // filled: true,
        fillColor: Color(BasicColors.tertiary),
        isCollapsed: true,
        border: InputBorder.none
        /*  enabledBorder: inputFieldBorder(
        isFocused: false,
        isDisplayingError: false,
      ),
      focusedBorder: inputFieldBorder(
        isFocused: true,
        isDisplayingError: false,
      ),
      errorBorder: inputFieldBorder(
        isFocused: false,
        isDisplayingError: true,
      ),
      focusedErrorBorder: inputFieldBorder(
        isFocused: true,
        isDisplayingError: false,
      ),**/
        //suffix: suffix,
        );
  }

  OutlineInputBorder inputFieldBorder({
    required bool isFocused,
    required bool isDisplayingError,
  }) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        width: isFocused ? 2.0 : 1.0,
        color: isDisplayingError ? Colors.redAccent : const Color(0xFFDADADA),
      ),
    );
  }

  Widget buttonForgetPassword(onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Checkbox(
                value: isRemeberMeClicked,
                onChanged: (value) {
                  onRemeberMeClicked();
                },
                activeColor: Colors.grey,
              ),
              Text('Remember me',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    shadows: textShadows(),
                  )),
            ],
          ),
          const Expanded(
            child: SizedBox(),
          ),
          const Text(
            'Forgot Password?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Color(BasicColors.primary),
            ),
          ),
          /* TextButton(
            onPressed: onPressed,
            child: const Text(
              'Forgot Password?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Color(BasicColors.primary),
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget buttonSignIn(onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(BasicColors.primary),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: const Padding(
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Log In',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Color(BasicColors.tertiary),
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
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
