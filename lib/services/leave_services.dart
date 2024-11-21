import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:org_connect_pt/helpers/api_validation_helper.dart';
import 'package:org_connect_pt/utils/constants.dart';
import 'package:org_connect_pt/utils/urls.dart';
import 'package:http/http.dart' as http;

class LeaveServices {
  static Future<dynamic> getLeaveBalances(
      String authToken, int employeeId) async {
    final queryParameters = {
      'employeeId': employeeId.toString(),
    };

    var url = Uri.http(Urls.baseUrl, Urls.getLeaveBalancesUrl, queryParameters);

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          Constants.headerContentType: Constants.contentTypeValue,
          /*Constants.headerAuthorization:
              Constants.authorizationBearerValue + authToken,*/
        },
      ).timeout(const Duration(seconds: Constants.defaultAPITimeout));

      if (response.statusCode == 401) {
        return 401;
      } /* else if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      }*/

      return validateAPIResponse(response);
      // return 'Unexpected API Response.';
    } on SocketException {
      throw Constants.socketException;
    } on TimeoutException {
      throw Constants.timeoutException;
    } catch (e) {
      throw Constants.generalException;
    }
  }

  static Future<dynamic> getLeaveTypes(
    String authToken,
  ) async {
    var url = Uri.http(
      Urls.baseUrl,
      Urls.getAllLeaveTypesUrl,
    );

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          Constants.headerContentType: Constants.contentTypeValue,
          /*Constants.headerAuthorization:
              Constants.authorizationBearerValue + authToken,*/
        },
      ).timeout(const Duration(seconds: Constants.defaultAPITimeout));

      if (response.statusCode == 401) {
        return 401;
      } /* else if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      }*/

      return validateAPIResponse(response);
      // return 'Unexpected API Response.';
    } on SocketException {
      throw Constants.socketException;
    } on TimeoutException {
      throw Constants.timeoutException;
    } catch (e) {
      throw Constants.generalException;
    }
  }

  static Future<dynamic> getPersonalLeaves(String authToken, int page) async {
    final queryParameters = {
      'emploeyeeId': '82',
      'page': page.toString(),
    };

    var url = Uri.http(Urls.baseUrl, Urls.getLeaveRequestsUrl, queryParameters);

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          Constants.headerContentType: Constants.contentTypeValue,
          /*Constants.headerAuthorization:
              Constants.authorizationBearerValue + authToken,*/
        },
      ).timeout(const Duration(seconds: Constants.defaultAPITimeout));

      if (response.statusCode == 401) {
        return 401;
      }

      return validateAPIResponse(response);
    } on SocketException {
      throw Constants.socketException;
    } on TimeoutException {
      throw Constants.timeoutException;
    } catch (e) {
      throw Constants.generalException;
    }
  }

  static Future<dynamic> getAllEmployeeLeaves(
      String authToken, int page, int departmentId) async {
    final queryParameters = {
      //  'departmentId': departmentId.toString(),
      'page': page.toString(),
    };

    var url = Uri.http(
        Urls.baseUrl, Urls.getEmployeeLeaveRequestsUrl, queryParameters);

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          Constants.headerContentType: Constants.contentTypeValue,
          /*Constants.headerAuthorization:
              Constants.authorizationBearerValue + authToken,*/
        },
      ).timeout(const Duration(seconds: Constants.defaultAPITimeout));

      if (response.statusCode == 401) {
        return 401;
      }

      return validateAPIResponse(response);
    } on SocketException {
      throw Constants.socketException;
    } on TimeoutException {
      throw Constants.timeoutException;
    } catch (e) {
      throw Constants.generalException;
    }
  }

  static Future<dynamic> getAllPendingLeaves(String authToken) async {
    final queryParameters = {
      'status': '${Constants.statusPending}',
    };

    var url = Uri.http(Urls.baseUrl, Urls.getLeaveRequestsUrl, queryParameters);

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          Constants.headerContentType: Constants.contentTypeValue,
          /*Constants.headerAuthorization:
              Constants.authorizationBearerValue + authToken,*/
        },
      ).timeout(const Duration(seconds: Constants.defaultAPITimeout));

      if (response.statusCode == 401) {
        return 401;
      }

      return validateAPIResponse(response);
    } on SocketException {
      throw Constants.socketException;
    } on TimeoutException {
      throw Constants.timeoutException;
    } catch (e) {
      throw Constants.generalException;
    }
  }

  static Future<dynamic> applyForLeave(
    String authToken,
    int employeeId,
    String startDate,
    String endDate,
    String reason,
    String startShiftId,
    String endShiftId,
    int backupEmployeeId,
    String contactNumber,
    int leaveTypeId,
    double count,
  ) async {
    final body = {
      'employeeId': employeeId.toString(),
      'startDate': startDate,
      'endDate': endDate,
      'leaveReason': reason,
      'leaveStartSegment': startShiftId.toString(),
      'leaveEndSegment': endShiftId.toString(),
      'backupEmployeeId': backupEmployeeId,
      'contactNumber': contactNumber,
      'leaveTypeId': leaveTypeId,
      'count': count,
    };

    var url = Uri.http(Urls.baseUrl, Urls.applyLeaveUrl);

    try {
      final response = await http
          .post(
            url,
            headers: <String, String>{
              Constants.headerContentType: Constants.contentTypeValue,
              /* Constants.headerAuthorization:
              Constants.authorizationBearerValue + authToken,*/
            },
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: Constants.defaultAPITimeout));

      if (response.statusCode == 401) {
        return 401;
      }

      return validateAPIResponse(response);
    } on SocketException {
      throw Constants.socketException;
    } on TimeoutException {
      throw Constants.timeoutException;
    } catch (e) {
      throw Constants.generalException;
    }
  }

  static Future<dynamic> changeLeaveRequestStatus(
      String authToken, int leaveId, int status) async {
    String queryParameters = leaveId.toString();

    final body = {"statusId": status};

    var url =
        Uri.http(Urls.baseUrl, Urls.approveLeaveRequestUrl + queryParameters);

    try {
      final response = await http
          .patch(
            url,
            headers: <String, String>{
              Constants.headerContentType: Constants.contentTypeValue,
              /* Constants.headerAuthorization:
              Constants.authorizationBearerValue + authToken,*/
            },
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: Constants.defaultAPITimeout));

      if (response.statusCode == 401) {
        return 401;
      }

      return validateAPIResponse(response);
    } on SocketException {
      throw Constants.socketException;
    } on TimeoutException {
      throw Constants.timeoutException;
    } catch (e) {
      throw Constants.generalException;
    }
  }

  static Future<dynamic> rejectLeaveRequest(
      String authToken, int leaveId, int status, String reason) async {
    String queryParameters = leaveId.toString();

    Map<String, Object> body;

    if (reason.isNotEmpty) {
      body = {"statusId": status, "rejectleavereason": reason};
    } else {
      body = {"statusId": status};
    }

    var url =
        Uri.http(Urls.baseUrl, Urls.approveLeaveRequestUrl + queryParameters);

    try {
      final response = await http
          .patch(
            url,
            headers: <String, String>{
              Constants.headerContentType: Constants.contentTypeValue,
              /* Constants.headerAuthorization:
              Constants.authorizationBearerValue + authToken,*/
            },
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: Constants.defaultAPITimeout));

      if (response.statusCode == 401) {
        return 401;
      }

      return validateAPIResponse(response);
    } on SocketException {
      throw Constants.socketException;
    } on TimeoutException {
      throw Constants.timeoutException;
    } catch (e) {
      throw Constants.generalException;
    }
  }
}
