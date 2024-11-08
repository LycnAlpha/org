import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/calendar_screen/calendar_screen_interface.dart';
import 'package:org_connect_pt/screens/calendar_screen/event_provider.dart';
import 'package:provider/provider.dart';

class CalendarScreenContent extends StatefulWidget {
  const CalendarScreenContent({super.key});

  @override
  State<CalendarScreenContent> createState() => _CalendarScreenContentState();
}

class _CalendarScreenContentState extends State<CalendarScreenContent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //refresh();
      getevents();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CalendarScreenInterface(
      refresh: getevents,
    );
  }

  Future<void> getevents() async {
    Provider.of<EventProvider>(
      context,
      listen: false,
    ).getEvents(context);
  }
}
