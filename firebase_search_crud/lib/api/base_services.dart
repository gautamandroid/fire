import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'api_default.dart';

class BaseServices {

  Future<ApiResponse> getData(String api) async {
    try {
      final response = await http.get(Uri.parse(api));
      final data = json.decode(response.body);

      return ApiResponse(message: 'message', statusCode: response.statusCode, data: data);
    } catch (e) {
      return ApiResponse(message: 'Error occurred : $e', statusCode: 500);
    }
  }

  // var userOtpData = {
  //   "username": phoneNumber,
  //   "mobileOtp": otpController.text.trim(),
  // };
  // ApiResponse response = await ApiService().postData(ApiRequest.verifyUser, userOtpData);
  // bool responseVerifyData = response.data['verifyMobileOtp'];
  // if (responseVerifyData) {
  // print('=====id===>${response.data['user']['id']}');

  Future<ApiResponse> postData(String api, Map<String, dynamic> data) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(api),
        headers: APIDefaults.defaultHeaders(),
        body: json.encode(data),
      );
      log("statusCode : ${response.statusCode}");
      log("request : ${response.request}");
      log("map : $data");
      log("Response : ${response.body}");
      if (response.statusCode == 401) {
        // showInSnackBar("Session expired");
        // Preferences.clearSharPreference();
        // Get.offAll(const LoginScreen());
      }
      final message = APIDefaults.showApiStatusMessage(response);
      final responseData = json.decode(response.body);
      return ApiResponse(message: message, statusCode: response.statusCode, data: responseData);
    } catch (e) {
      return ApiResponse(message: "Error occurred: $e", statusCode: 500);
    }
  }

}



class ApiResponse {
  final String message;
  final int statusCode;
  final dynamic data;

  ApiResponse({required this.message, required this.statusCode, this.data});
}
