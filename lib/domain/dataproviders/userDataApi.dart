import 'dart:convert';
import 'package:docmehr/core/constants.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Future<http.Response> getUserDataApi(
      {required String userToken,
      required String deviceId,
      required String otp}) async {
    String url = ApiConstants.getUserData;
    Map<String, String> apiHeader = ApiConstants().apiHeader;
    Map<String, String> body = {
      "UserToken": userToken,
      "DeviceId": deviceId,
      "OTPNo": otp
    };
    var request = http.Request('POST', Uri.parse(url));
    request.body = (json.encode(body));
    request.headers.addAll(apiHeader);
    print(url);
    print("----Api body-----${request.body}");
    http.StreamedResponse response = await request.send();
    var respString = await response.stream.bytesToString();
    return http.Response(respString, response.statusCode);
  }
}
