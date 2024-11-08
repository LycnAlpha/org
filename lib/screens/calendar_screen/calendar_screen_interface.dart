import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:org_connect_pt/screens/calendar_screen/calendar_screen_widgets/event_calendar.dart';
import 'package:org_connect_pt/screens/calendar_screen/event_provider.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';

class CalendarScreenInterface extends StatelessWidget {
  final refresh;
  const CalendarScreenInterface({
    super.key,
    this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(
          10.0,
        ),
        color: const Color(BasicColors.tertiary),
        child:
            Consumer<EventProvider>(builder: (context, eventProvider, child) {
          if (eventProvider.isLoading) {
            return const Center(
              child: SpinKitCircle(
                color: Color(BasicColors.primary),
              ),
            );
          } else if (eventProvider.errorOccured) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  eventProvider.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.red,
                      fontWeight: FontWeight.w400),
                ),
                IconButton(
                    onPressed: refresh,
                    icon: const Icon(
                      Icons.refresh,
                      color: Colors.red,
                      size: 30,
                    ))
              ],
            );
          } else {
            return EventCalendar(
              refresh: refresh,
            );
          }
        }));
  }
}
