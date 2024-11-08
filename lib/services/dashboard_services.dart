import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:org_connect_pt/helpers/api_validation_helper.dart';
import 'package:org_connect_pt/utils/constants.dart';
import 'package:org_connect_pt/utils/urls.dart';

class DashboardServices {
  static Future<dynamic> getEventsAndHolidays(String authToken) async {
    var url = Uri.http(Urls.baseUrl, '${Urls.getEventsAndHoldaysUrl}/82');

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
