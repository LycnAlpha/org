class Leave {
  int leaveId;
  int employeeId;
  String employeeName;
  String startDate;
  String endDate;
  int statusId;
  String statusDescription;
  String reason;
  String? leaveRejectionReason;
  int? startShiftId;
  String? startShiftName;
  int? endShiftId;
  String? endShiftName;
  int backupEmployeeId;
  String backupEmployeeName;
  String contactNumber;
  int? leaveTypeId;
  String? leavetypeName;
  double? dayCount;
  String? startSegment;
  String? endSegment;

  Leave({
    required this.leaveId,
    required this.employeeId,
    required this.employeeName,
    required this.startDate,
    required this.endDate,
    required this.statusId,
    required this.statusDescription,
    required this.reason,
    this.leaveRejectionReason,
    this.startShiftId,
    this.startShiftName,
    this.endShiftId,
    this.endShiftName,
    required this.backupEmployeeId,
    required this.backupEmployeeName,
    required this.contactNumber,
    this.leaveTypeId,
    this.leavetypeName,
    this.dayCount,
    this.startSegment,
    this.endSegment,
  });

  factory Leave.fromJson(dynamic json) {
    return Leave(
      leaveId: json['uid'],
      employeeId: json['employeeId'],
      employeeName: json['fullName'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      statusId: json['statusId'],
      statusDescription: json['statusDescription'],
      reason: json['leaveReason'],
      leaveRejectionReason: json['rejectLeaveReason'],
      startShiftId: json['startShiftId'],
      startShiftName: json['startShiftName'],
      endShiftId: json['endShiftId'],
      endShiftName: json['endShiftName'],
      backupEmployeeId: json['backupEmployeeId'],
      backupEmployeeName: json['backupEmployeeName'],
      contactNumber: json['contactNumber'],
      leaveTypeId: json['leaveTypeId'],
      leavetypeName: json['leaveTypeName'],
      dayCount: json['count'],
      startSegment: json['leaveStartSegment'] == '1' ? 'Morning' : 'Evening',
      endSegment: json['leaveEndSegment'] == '1' ? 'Morning' : 'Evening',
    );
  }

  /* factory Leave.fromJson(dynamic json) {
    final leaveRequest = json['leaveRequestResponseDTO'];
    final detailsMap = json['details'];

    Map<String, dynamic> details = {};

    if (detailsMap.isNotEmpty) {
      details = detailsMap[0];
    }

    return Leave(
      leaveId: leaveRequest['uid'],
      employeeId: leaveRequest['employeeId'],
      employeeName: leaveRequest['fullName'],
      startDate: leaveRequest['startDate'],
      endDate: leaveRequest['endDate'],
      statusId: leaveRequest['statusId'],
      statusDescription: leaveRequest['statusDescription'],
      reason: leaveRequest['leaveReason'],
      leaveRejectionReason: leaveRequest['rejectLeaveReason'],
      startShiftId: leaveRequest['startShiftId'],
      startShiftName: leaveRequest['startShiftName'],
      endShiftId: leaveRequest['endShiftId'],
      endShiftName: leaveRequest['endShiftName'],
      backupEmployeeId: leaveRequest['backupEmployeeId'],
      backupEmployeeName: leaveRequest['backupEmployeeName'],
      contactNumber: leaveRequest['contactNumber'],
      leaveTypeId: details['leaveTypeId'],
      leavetypeName: details['leaveTypeName'],
      dayCount: details['count'],
      startSegment: leaveRequest['leaveStartSegment'],
      endSegment: leaveRequest['leaveEndSegment'],
    );
  }*/
}
