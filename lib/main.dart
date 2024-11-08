import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:org_connect_pt/screens/splash_screen/splash_screen.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Color(BasicColors.tertiary),
          statusBarIconBrightness: Brightness.dark),
    );
    return MaterialApp(
      title: 'OrgConnect',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color(BasicColors.tertiary)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
