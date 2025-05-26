import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;


class APIDefaults {
  static Map<String, String> defaultHeaders() => {
    HttpHeaders.contentTypeHeader: 'application/json',

    // "Authorization": Preferences.getString(Preferences.accessToken
    // ),
  };

  static String showApiStatusMessage(http.Response response, [String? message]) {
    Map<String, dynamic> map = jsonDecode(response.body ?? "{}");
    String messageString = message.toString();

    switch (response.statusCode) {
      case 200: // OK
        messageString = map['message'] ?? (message ?? "Success.");
        break;
      case 201: // Created
        messageString = map['message'] ?? (message ?? "Created successfully.");
        break;
      case 400: // Bad Request
        messageString = map['message'] ?? (message ?? "Bad request. Please check your input.");
        break;
      case 401: // Unauthorized
        messageString = map['message'] ?? (message ?? "User not found!. Please create account.");
        break;
      case 403: // Forbidden
        messageString = map['message'] ?? (message ?? "Forbidden. Access is denied.");
        break;
      case 404: // Not Found
        messageString = map['message'] ?? (message ?? "Not found. The resource doesn't exist.");
        break;
      case 500: // Internal Server Error
        messageString = map['message'] ?? (message ?? "Internal server error. Please try again later.");
        break;
      case 502: // Bad Gateway
        messageString = map['message'] ?? (message ?? "Bad gateway. Please try again later.");
        break;
      case 503: // Service Unavailable
        messageString = map['message'] ?? (message ?? "Service unavailable. Please try again later.");
        break;
      case 504: // Gateway Timeout
        messageString = map['message'] ?? (message ?? "Gateway timeout. Please try again later.");
        break;
      case 422: // Gateway Timeout
        messageString = map['message'] ?? (message ?? "User already exists.");
        break;
      default:
        // messageString = map['message'] ?? (message ?? ConstString.somethingWentWrong);
    }

    if (response.statusCode == null) {
      messageString = "Internet connection unstable. Please retry in a moment.";
    }

    return messageString;
  }
}
