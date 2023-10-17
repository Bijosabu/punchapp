import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:docmehr/core/constants.dart';
import 'package:docmehr/core/mainfailures/failures.dart';
import 'package:docmehr/domain/models/otpModel.dart';
import 'package:http/http.dart' as http;

class OtpRepo {
  Future<Either<MainFailure, OTPModel>> getOtp(
    String mobNum,
    String deviceId,
    String signature,
  ) async {
    final Map<String, String> body = {
      "MobileNo": mobNum,
      "DeviceId": deviceId,
      "Signature": signature,
    };
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.getOtp),
        headers: ApiConstants().apiHeader,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        final otpModel = OTPModel.fromJson(jsonMap);
        return right(otpModel);
      } else {
        return left(const MainFailure.clientFailure());
      }
    } catch (e) {
      return left(const MainFailure.clientFailure());
    }
  }
}
