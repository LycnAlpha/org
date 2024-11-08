import 'package:org_connect_pt/models/employee_details.dart';

class Event {
  DateTime date;
  EmployeeDetails? employeeDetails;
  String? employeeFirstName;
  String? employeeLastName;
  String? eventName;
  String? status;

  Event({
    required this.date,
    this.employeeFirstName,
    this.employeeLastName,
    this.eventName,
    this.employeeDetails,
    this.status,
  });

  factory Event.fromJson(dynamic json, String status) {
    return Event(
      date: DateTime.parse(json['date']),
      eventName: json['name'],
      status: status,
    );
  }
}
