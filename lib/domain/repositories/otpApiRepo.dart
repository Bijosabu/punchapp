import 'dart:convert';
import 'package:docmehr/domain/dataproviders/otpApi.dart';
import 'package:http/http.dart';
import '../models/otpModel.dart';

class OTPRepository {
  OTPApi api = OTPApi();

  Future<OTPModel> getOTP(
      {required String mobNum,
      required String deviceId,
      required String signature}) async {
    final Response otpRes = await api.getOtpApi(
        mobNum: mobNum, deviceId: deviceId, signature: signature);

    if (otpRes.statusCode == 200) {
      final Map<String, dynamic> jsonOTP = jsonDecode(otpRes.body);
      final OTPModel apiToDart = OTPModel.fromJson(jsonOTP);
      return apiToDart;
    } else {
      throw Exception("Failed to fetch otpApi");
    }
  }
}
