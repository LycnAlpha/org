import 'dart:convert';
import 'package:org_connect_pt/models/api_response.dart';
import 'package:org_connect_pt/models/error_response.dart';
import 'package:org_connect_pt/utils/constants.dart';

dynamic validateAPIResponse(response) {
  try {
    //APIResponse responseBody = APIResponse.fromJson(json.decode(response.body));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return APIResponse.fromJson(json.decode(response.body));
    } else {
      ErrorResponse errorResponse =
          ErrorResponse.fromJson(json.decode(response.body));
      if (errorResponse.error.isNotEmpty) {
        return errorResponse.error;
      } else if (errorResponse.status.isNotEmpty) {
        return errorResponse.status;
      } else if (errorResponse.exceptionCode.isNotEmpty) {
        return 'Error: ${errorResponse.exceptionCode}';
      } else {
        return "Error Occurred! Please Contact Support.";
      }
    }
  } catch (e) {
    return 'Unexpected API Response.';
  }
}

String getErrorMessage(int errorCode) {
  switch (errorCode) {
    case 9091:
      return 'Record create failed';
    case 9092:
      return 'Record fetch failed';
    case 9093:
      return 'Record update failed';
    case 9095:
      return 'Record not found';
    case 9097:
      return 'File upload failed';
    case Constants.socketException:
      return 'Oops! No Internet Connection';
    case Constants.timeoutException:
      return 'Connection Timeout!\nTry Again Later.';
    case Constants.generalException:
      return 'Service Error Occurred';
    case Constants.nullException:
      return 'Results not available';
    case Constants.unknownException:
      return 'Unknown Error Occurred';
  }

  return 'Error Occurred';
}
