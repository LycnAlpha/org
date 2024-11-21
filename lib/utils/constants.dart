class Constants {
  //For QA releases
  static const String applicationVersion = '1.0.0';

  //For Production releases
  //static const String applicationVersion = '1.0.0';

  //For Dashboard Page Screens
  static const int dashboardScreen = 0;
  static const int calendarScreen = 1;
  static const int myProfileScreen = 2;
  static const int moreScreen = 3;

  static const String dashboard = 'Dashboard';
  static const String calendar = 'Calendar';
  static const String myProfile = 'My Profile';
  static const String more = 'More';

  //Shared Preference Keys
  static const String permissionLevel = 'PERMISSION_LEVEL';
  static const String authToken = 'AUTHENTICATION_TOKEN';
  static const String refreshToken = 'REFRESH_TOKEN';

  //Permission levels
  static const int permissionLevelNone = 0;
  static const int permissionLevelEmployee = 1;
  static const int permissionLevelSupervisor = 2;
  static const int permissionLevelHRAdmin = 3;
  static const int permissionLevelHRHOD = 4;

  //API error codes
  static const int socketException = 2000;
  static const int timeoutException = 2001;
  static const int generalException = 2002;
  static const int unknownException = 2004;
  static const int nullException = 2003;

  //API headers
  static const String headerContentType = 'Content-Type';
  static const String authorizationBearerValue = 'Bearer ';
  static const String headerAuthorization = 'Authorization';
  static const String contentTypeValue = 'application/json';

  //Default API timeout
  static const int defaultAPITimeout = 30;

  //Leave Segment Codes
  static const String segmentMorning = "First Half";
  static const String segmentEvening = "Second Half";

  //statuses
  static const int statusPending = 10;
  static const int statusApproved = 20;
  static const int statusRejected = 30;
  static const int statusReviewed = 40;
  static const int statusRequestToCancel = 50;
  static const int statusCanceled = 60;
  static const int statusReported = 70;
  static const int statusUnderInvestigation = 80;
  static const int statusResolved = 90;
  static const int statusPendingAcknowledgement = 100;
}
