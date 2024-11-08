class LeaveType {
  int typeId;
  String leaveTypeCode;
  String leaveTypeName;

  LeaveType({
    required this.typeId,
    required this.leaveTypeCode,
    required this.leaveTypeName,
  });

  factory LeaveType.fromJson(dynamic json) {
    return LeaveType(
      typeId: json['uid'],
      leaveTypeCode: json['leaveTypeCode'],
      leaveTypeName: json['leaveTypeName'],
    );
  }
}
