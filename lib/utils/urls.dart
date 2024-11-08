class Urls {
  //for Dev server
  static const String baseUrl = '192.168.100.152:8081';

  //for login
  static const String loginUrl = '/api/V1/auth/login';

  //for permission
  static const String getPermissionUrl = '/api/V1/auth/permissions';

  //for events and holidays
  static const String getEventsAndHoldaysUrl =
      '/api/V1/mobile/empdashboard/dates';

  //for leave balance
  static const String getLeaveBalancesUrl = '/api/V1/leaveledger';

  //for getting all leave types
  static const String getAllLeaveTypesUrl = '/api/V1/leavetype';

  //for leave requests
  static const String getLeaveRequestsUrl = '/api/V1/leaverequest';

  //for getting employees list
  static const String getEmployeesUrl = '/api/V1/employee';

  //for applying for a leave
  static const String applyLeaveUrl = '/api/V1/leaverequest';

  //for getting leave requests of employees in department
  static const String getEmployeeLeaveRequestsUrl = '/api/V1/leaverequest';

  //for approving a leave request
  static const String approveLeaveRequestUrl = '/api/V1/leaverequest/';

  //for getting all holidays
  static const String getHolidaysUrl = '/api/V1/holiday';
}
