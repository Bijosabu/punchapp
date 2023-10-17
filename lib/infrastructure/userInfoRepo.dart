import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:docmehr/core/constants.dart';
import 'package:docmehr/core/mainfailures/failures.dart';
import 'package:docmehr/domain/models/userInfoModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserInfoRepo {
  Future<Either<MainFailure, UserInfoModel>> getUserInfo(
    String userToken,
    String deviceId,
    String otpNo,
  ) async {
    final Map<String, String> body = {
      "UserToken": userToken,
      "DeviceId": deviceId,
      "OTPNo": otpNo,
    };
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.getUserData),
        headers: ApiConstants().apiHeader,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(response.body);
        final UserInfoModel user = UserInfoModel.fromJson(jsonMap);
        if (kDebugMode) {
          print(user);
        }
        return right(user);
      } else {
        return left(const MainFailure.serverFailure());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return left(const MainFailure.clientFailure());
    }
  }
}
