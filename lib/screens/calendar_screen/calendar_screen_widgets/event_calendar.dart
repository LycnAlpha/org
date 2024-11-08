import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:org_connect_pt/models/event.dart';
import 'package:org_connect_pt/screens/calendar_screen/calendar_screen_widgets/event_card.dart';
import 'package:org_connect_pt/screens/calendar_screen/event_provider.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendar extends StatefulWidget {
  final refresh;
  const EventCalendar({
    super.key,
    this.refresh,
  });

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  var _selectedEvents;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = _getEventsForDay(_selectedDay!);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(builder: (context, eventProvider, child) {
      return SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(BasicColors.tertiary),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: const Offset(0, 0),
                          blurRadius: 2,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: TableCalendar<Event>(
                        onDaySelected: _onDaySelected,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        firstDay: DateTime(DateTime.now().year),
                        lastDay: DateTime(DateTime.now().year, 13),
                        focusedDay: _focusedDay,
                        calendarFormat: CalendarFormat.month,
                        eventLoader: _getEventsForDay,
                        headerVisible: true,
                        rowHeight: 45,
                        headerStyle: HeaderStyle(
                            headerPadding: const EdgeInsets.all(0.0),
                            titleCentered: true,
                            formatButtonVisible: false,
                            titleTextStyle: customTextStyle()),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: const Color(BasicColors.primary)
                                .withOpacity(0.25),
                            // overflow: TextOverflow.fade,
                          ),
                          weekendStyle: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: const Color(BasicColors.primary)
                                .withOpacity(0.25),
                          ),
                        ),
                        calendarStyle: CalendarStyle(
                          cellMargin: const EdgeInsets.all(10),
                          outsideDaysVisible: false,
                          weekendTextStyle: TextStyle(
                              color: const Color(BasicColors.primary)
                                  .withOpacity(0.5),
                              fontWeight: FontWeight.bold),
                          outsideTextStyle: TextStyle(
                              color: const Color(BasicColors.primary)
                                  .withOpacity(0.5),
                              fontWeight: FontWeight.bold),
                          selectedDecoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(BasicColors.secondary)),
                          selectedTextStyle: const TextStyle(
                              color: Color(BasicColors.tertiary),
                              fontWeight: FontWeight.bold),
                          todayTextStyle: const TextStyle(
                              color: Color(BasicColors.primary),
                              fontWeight: FontWeight.bold),
                          todayDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: const Color(BasicColors.secondary))),
                          defaultTextStyle: const TextStyle(
                              color: Color(BasicColors.primary),
                              fontWeight: FontWeight.bold),
                          markersMaxCount: 1,
                          markerDecoration: const BoxDecoration(
                              color: Colors.amber, shape: BoxShape.circle),
                        ))),
              ),
              eventsHeader(_selectedDay ?? DateTime.now()),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ListView.builder(
                    itemCount: _selectedEvents.length,
                    itemBuilder: (context, index) {
                      return EventCard(
                        event: _selectedEvents[index],
                        index: index,
                      );
                    }),
              ))
            ],
          ),
        ),
      );
    });
  }

  TextStyle customTextStyle() {
    return const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      color: Color(BasicColors.primary),
      // overflow: TextOverflow.fade,
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents = _getEventsForDay(selectedDay);

      /*  if (_selectedEvents.isNotEmpty) {
        showDialog(
            context: context,
            builder: (ctx) => TodaysEventDialog(events: _selectedEvents));
      }*/
    }
  }

  Widget eventsHeader(DateTime date) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat('EEE').format(date).toUpperCase(),
                  style: TextStyle(
                      fontSize: 20.0,
                      color: const Color(BasicColors.primary).withOpacity(0.25),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat('dd').format(date),
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Color(BasicColors.primary),
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const SizedBox(
              width: 20.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSameDay(date, DateTime.now().add(const Duration(days: 1)))
                      ? 'Tomorrow'
                      : date.difference(DateTime.now()).inDays == 0
                          ? 'Today'
                          : date.difference(DateTime.now()).inDays == -1
                              ? 'Yesterday'
                              : '',
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Color(BasicColors.primary),
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  _selectedEvents.length > 1
                      ? '${_selectedEvents.length} events'
                      : _selectedEvents.length == 1
                          ? '${_selectedEvents.length} event'
                          : 'No events for the day',
                  style: TextStyle(
                      fontSize: 14.0,
                      color: const Color(BasicColors.primary).withOpacity(0.25),
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ));
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return Provider.of<EventProvider>(
      context,
      listen: false,
    ).getTodaysEvents(day);
  }
}
