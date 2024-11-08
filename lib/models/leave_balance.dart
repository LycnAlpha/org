class LeaveBalance {
  int id;
  String leavetypeName;
  double balanceCount;
  double entitledCount;
  double holdCount;

  LeaveBalance({
    required this.id,
    required this.leavetypeName,
    required this.balanceCount,
    required this.entitledCount,
    required this.holdCount,
  });

  factory LeaveBalance.fromJson(dynamic json) {
    return LeaveBalance(
        id: json['leaveTypeId'],
        leavetypeName: json['leaveTypeName'],
        balanceCount: json['balanceCount'],
        entitledCount: json['entitledCount'],
        holdCount: json['holdCount']);
  }
}
