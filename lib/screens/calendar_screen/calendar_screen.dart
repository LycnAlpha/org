import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/calendar_screen/calendar_screen_content.dart';
import 'package:org_connect_pt/screens/calendar_screen/event_provider.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EventProvider(),
        ),
      ],
      child: const CalendarScreenContent(),
    );
  }
}
