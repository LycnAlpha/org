import 'dart:async';
import 'dart:io';

import 'package:org_connect_pt/helpers/api_validation_helper.dart';
import 'package:org_connect_pt/utils/constants.dart';
import 'package:org_connect_pt/utils/urls.dart';
import 'package:http/http.dart' as http;

class EmployeeServices {
  static Future<dynamic> getAllEmployeesList(String authToken, int page) async {
    final queryParameters = {
      'page': page.toString(),
    };
    var url = Uri.http(
      Urls.baseUrl,
      Urls.getEmployeesUrl,
      queryParameters,
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

  static Future<dynamic> getAllEmployeesInDepartment(
      String authToken, int departmentId) async {
    final queryParameters = {
      'department': departmentId.toString(),
    };
    var url = Uri.http(
      Urls.baseUrl,
      Urls.getEmployeesUrl,
      queryParameters,
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
