import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/landing_page/bottom_navigation_provider.dart';
import 'package:org_connect_pt/screens/landing_page/landing_page_content.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomNavigationProvider(),
        ),
      ],
      child: const LandingPageContent(),
    );
  }
}
