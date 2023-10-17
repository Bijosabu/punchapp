import 'dart:convert';
import 'package:docmehr/domain/dataproviders/userDataApi.dart';
import 'package:http/http.dart';
import '../models/userModel.dart';

class UserRepository {
  UserApi api = UserApi();

  Future<User> getUserData(
      {required String userToken,
      required String deviceId,
      required String otp}) async {
    final Response respData = await api.getUserDataApi(
        userToken: userToken, deviceId: deviceId, otp: otp);

    if (respData.statusCode == 200) {
      final Map<String, dynamic> jsonOTP = jsonDecode(respData.body);
      final User apiToDart = User.fromJson(jsonOTP);
      return apiToDart;
    } else {
      throw Exception("Failed to fetch userDataApi");
    }
  }
}
