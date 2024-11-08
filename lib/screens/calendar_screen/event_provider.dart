import 'package:flutter/material.dart';
import 'package:org_connect_pt/helpers/api_validation_helper.dart';
import 'package:org_connect_pt/helpers/shared_preference_helper.dart';
import 'package:org_connect_pt/models/api_response.dart';
import 'package:org_connect_pt/models/event.dart';
import 'package:org_connect_pt/screens/login_screen/login_screen.dart';
import 'package:org_connect_pt/services/dashboard_services.dart';
import 'package:org_connect_pt/utils/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class EventProvider extends ChangeNotifier {
  bool isLoading = true;
  bool errorOccured = false;
  bool isEmptyList = false;
  String message = '';

  List<Event> events = [];
  List<Event> todayEvents = [];

  Future<void> getEvents(BuildContext context) async {
    isLoading = true;
    errorOccured = false;
    isEmptyList = false;

    notifyListeners();

    String authToken = await SharedPreferenceHelper.getAuthToken();

    await DashboardServices.getEventsAndHolidays(authToken).then((result) {
      try {
        if (result != null) {
          if (result is String) {
            _onFailed(result);
          } else if (result is int) {
            _sessionExpired(context);
          } else {
            //success
            _onSuccess(result);
          }
        } else {
          _onFailed(getErrorMessage(Constants.nullException));
        }
      } catch (e) {
        _onFailed(getErrorMessage(Constants.unknownException));
      }
    }, onError: (errorCode) {
      _onFailed(getErrorMessage(errorCode));
    });
  }

  _onSuccess(APIResponse response) {
    try {
      List<Event> holidaysList = response.data["Holidays"]
          .map((event) => Event.fromJson(event, 'Holiday'))
          .toList()
          .cast<Event>();

      List<Event> pendingLevesList = response.data['Pending Leave']
          .map((event) => Event.fromJson(event, 'Pending Leave'))
          .toList()
          .cast<Event>();

      List<Event> eventList = response.data['Events']
          .map((event) => Event.fromJson(event, 'Event'))
          .toList()
          .cast<Event>();

      List<Event> approvedLevesList = response.data['Approved Leave']
          .map((event) => Event.fromJson(event, 'Approved Leave'))
          .toList()
          .cast<Event>();

      events.addAll(holidaysList);
      events.addAll(pendingLevesList);
      events.addAll(eventList);
      events.addAll(approvedLevesList);

      if (events.isNotEmpty) {
        isLoading = false;
        errorOccured = false;

        notifyListeners();
      } else {
        isEmptyList = true;
        _onFailed('No records available');
      }
    } catch (e) {
      _onFailed(getErrorMessage(Constants.unknownException));
    }
  }

  List<Event> getTodaysEvents(DateTime day) {
    todayEvents = [];
    for (Event event in events) {
      if (isSameDay(event.date, day)) {
        todayEvents.add(event);
      }
    }
    //notifyListeners();
    return todayEvents;
  }

  _onFailed(String message) {
    isLoading = false;

    this.message = message;
    errorOccured = true;

    notifyListeners();
  }

  _sessionExpired(BuildContext context) {
    _onFailed('Session Expired');
    openLoginScreen(context);
  }

  openLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}
