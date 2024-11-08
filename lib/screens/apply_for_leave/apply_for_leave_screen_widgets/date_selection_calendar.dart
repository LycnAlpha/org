import 'package:flutter/material.dart';
import 'package:org_connect_pt/models/holiday.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/apply_for_leave_data_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/holidays_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_widgets/custom_background.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_widgets/from_segment_selection_dialog.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_widgets/to_segment_selection_dialog.dart';
import 'package:org_connect_pt/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DateSelectionCalendar extends StatefulWidget {
  final ApplyForLeaveDataProvider applyForLeaveDataProvider;
  const DateSelectionCalendar({
    super.key,
    required this.applyForLeaveDataProvider,
  });

  @override
  State<DateSelectionCalendar> createState() => _DateSelectionCalendarState();
}

class _DateSelectionCalendarState extends State<DateSelectionCalendar> {
  DateTime? _focusedDay;
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.applyForLeaveDataProvider.selectedFromDate != null) {
        _focusedDay = widget.applyForLeaveDataProvider.selectedFromDate!;
        _rangeStart = widget.applyForLeaveDataProvider.selectedFromDate!;
      } else if (widget.applyForLeaveDataProvider.selectedFromDate != null) {
        _rangeEnd = widget.applyForLeaveDataProvider.selectedToDate!;
      }

      widget.applyForLeaveDataProvider
          .setHolidayList(Provider.of<HolidaysProvider>(
        context,
        listen: false,
      ).holidays);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: CustomBackground(
        child: TableCalendar(
          calendarFormat: CalendarFormat.month,
          headerVisible: true,
          headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: customTextStyle()),
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: customTextStyle(), weekendStyle: customTextStyle()),
          calendarStyle: CalendarStyle(
            markerDecoration: const BoxDecoration(color: Colors.amber),
            rangeEndDecoration: BoxDecoration(
                border:
                    Border.all(color: const Color(0xffFB9F2D).withOpacity(0.5)),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: widget.applyForLeaveDataProvider.selectedToSegment ==
                          Constants.segmentMorning
                      ? const AssetImage(
                          'assets/icons/icon_segment_morning.png')
                      : const AssetImage(
                          'assets/icons/icon_segment_full_day.png'),
                )),
            rangeStartDecoration: BoxDecoration(
                border:
                    Border.all(color: const Color(0xffFB9F2D).withOpacity(0.5)),
                shape: BoxShape.circle,
                image: DecorationImage(
                  //implement full circle image for the full day
                  image: (isSameDay(
                              widget.applyForLeaveDataProvider.selectedFromDate,
                              widget
                                  .applyForLeaveDataProvider.selectedToDate) &&
                          widget.applyForLeaveDataProvider
                                  .selectedFromSegment ==
                              Constants.segmentMorning &&
                          widget.applyForLeaveDataProvider.selectedToSegment ==
                              Constants.segmentMorning)
                      ? const AssetImage(
                          'assets/icons/icon_segment_morning.png')
                      : widget.applyForLeaveDataProvider.selectedFromSegment ==
                              Constants.segmentEvening
                          ? const AssetImage(
                              'assets/icons/icon_segment_evening.png')
                          : const AssetImage(
                              'assets/icons/icon_segment_full_day.png'),
                )),
            rangeStartTextStyle: customTextStyle(),
            rangeEndTextStyle: customTextStyle(),
            rangeHighlightColor: const Color(0xffFB9F2D).withOpacity(0.5),
            todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff1C577D).withOpacity(0.5)),
          ),
          firstDay: DateTime(DateTime.now().year),
          lastDay: DateTime(DateTime.now().year, 13),
          focusedDay: _focusedDay ?? DateTime.now(),
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          rangeSelectionMode: _rangeSelectionMode,
          onRangeSelected: (start, end, focusedDay) {
            setState(() {
              if (_rangeStart == null) {
                _selectedDay = null;
                _focusedDay = focusedDay;
                _rangeStart = focusedDay;
                _rangeEnd = null;
              } else if (_rangeStart != null && _rangeEnd == null) {
                if (focusedDay.isBefore(_rangeStart!) &&
                    !(isSameDay(
                            widget.applyForLeaveDataProvider.selectedFromDate,
                            widget.applyForLeaveDataProvider.selectedToDate) &&
                        widget.applyForLeaveDataProvider.selectedFromSegment ==
                            Constants.segmentMorning &&
                        widget.applyForLeaveDataProvider.selectedToSegment ==
                            Constants.segmentEvening)) {
                  _selectedDay = null;
                  _focusedDay = focusedDay;
                  //_rangeEnd = focusedDay;
                  _rangeEnd = null;
                  _rangeStart = focusedDay;
                  widget.applyForLeaveDataProvider.setFromDateSelected(false);
                } else {
                  if (isSameDay(
                          widget.applyForLeaveDataProvider.selectedFromDate,
                          widget.applyForLeaveDataProvider.selectedToDate) &&
                      widget.applyForLeaveDataProvider.selectedFromSegment ==
                          Constants.segmentMorning &&
                      widget.applyForLeaveDataProvider.selectedToSegment ==
                          Constants.segmentEvening) {
                    _selectedDay = null;
                    _rangeEnd = null;
                    _rangeStart = focusedDay;
                    _focusedDay = focusedDay;
                    widget.applyForLeaveDataProvider.setFromDateSelected(false);
                  } else {
                    _selectedDay = null;
                    _focusedDay = focusedDay;

                    _rangeEnd = focusedDay;
                  }
                }
              } else {
                _selectedDay = null;
                _rangeEnd = null;
                _rangeStart = focusedDay;
                _focusedDay = focusedDay;
              }

              _rangeSelectionMode = RangeSelectionMode.toggledOn;
            });

            widget.applyForLeaveDataProvider.fromDateSelected
                ? showDialog(
                    context: context,
                    builder: (ctx) => ToSegmentSelectionDialog(
                      applyForLeaveDataProvider:
                          widget.applyForLeaveDataProvider,
                      focusedDay: focusedDay,
                      rangeEnd: _rangeEnd,
                      rangeStart: _rangeStart,
                    ),
                  ).then((value) {
                    widget.applyForLeaveDataProvider.setFromDateSelected(false);
                  })
                : showDialog(
                    context: context,
                    builder: (ctx) => FromSegmentSelectionDialog(
                      applyForLeaveDataProvider:
                          widget.applyForLeaveDataProvider,
                      focusedDay: focusedDay,
                      rangeEnd: _rangeEnd,
                      rangeStart: _rangeStart,
                    ),
                  ).then((value) {
                    widget.applyForLeaveDataProvider.setFromDateSelected(true);
                  });
          },
          enabledDayPredicate: (day) {
            /*  for (var element in widget.disabledDateProvider.disabledDates) {
                  if (isSameDay(DateTime.parse(element.date), day)) {
                    if (element.segment != null) {
                      if (element.segment == 1 || element.segment == 2) {
                        return true;
                      } else {
                        return false;
                      }
                    }
                    return false;
                  }
                }*/
            if (widget.applyForLeaveDataProvider.holidays.isNotEmpty) {
              for (Holiday holiday
                  in widget.applyForLeaveDataProvider.holidays) {
                if ((day.isAfter(DateTime.parse(holiday.fromDate)) &&
                        day.isBefore(DateTime.parse(holiday.toDate))) ||
                    isSameDay(day, DateTime.parse(holiday.fromDate)) ||
                    isSameDay(day, DateTime.parse(holiday.toDate))) {
                  return false;
                }
              }
            }

            if (day.weekday == DateTime.saturday ||
                day.weekday == DateTime.sunday) {
              return false;
            }
            /*  if (widget.isToDate &&
                    widget.applyForLeaveDataProvider.selectedFromDate != null) {
                  if (day.isBefore(
                      widget.applyForLeaveDataProvider.selectedFromDate!)) {
                    return false;
                  }
                }*/

            return true;
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _rangeStart = null; // Important to clean those
                _rangeEnd = null;
                _rangeSelectionMode = RangeSelectionMode.toggledOff;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
      ),
    );
  }

  TextStyle customTextStyle() {
    return const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Color(0xff1C577D),
      // overflow: TextOverflow.fade,
    );
  }
}
