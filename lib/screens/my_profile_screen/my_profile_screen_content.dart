import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/my_profile_screen/my_profile_screen_interface.dart';

class MyProfileScreenContent extends StatefulWidget {
  const MyProfileScreenContent({super.key});

  @override
  State<MyProfileScreenContent> createState() => _MyProfileScreenContentState();
}

class _MyProfileScreenContentState extends State<MyProfileScreenContent> {
  @override
  Widget build(BuildContext context) {
    return const MyProfileScreenInterface();
  }
}
