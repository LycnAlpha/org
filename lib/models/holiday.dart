class Holiday {
  String code;
  String name;
  String fromDate;
  String toDate;
  int calendarCategoryId;
  String calendarCategoryName;

  Holiday({
    required this.code,
    required this.name,
    required this.fromDate,
    required this.toDate,
    required this.calendarCategoryId,
    required this.calendarCategoryName,
  });

  factory Holiday.fromJson(dynamic json) {
    return Holiday(
      code: json['code'],
      name: json['name'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      calendarCategoryId: json['calendarCategoryId'],
      calendarCategoryName: json['calendarCategoryName'],
    );
  }
}
