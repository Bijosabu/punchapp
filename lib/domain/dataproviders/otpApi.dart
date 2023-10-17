import 'dart:convert';
import 'package:docmehr/core/constants.dart';
import 'package:http/http.dart' as http;

class OTPApi {
  Future<http.Response> getOtpApi(
      {required String mobNum,
      required String deviceId,
      required String signature}) async {
    String url = ApiConstants.getOtp;
    Map<String, String> apiHeader = ApiConstants().apiHeader;
    Map<String, String> body = {
      "MobileNo": mobNum,
      "DeviceId": deviceId,
      "Signature": signature
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
