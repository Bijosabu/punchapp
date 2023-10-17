part of 'user_info_bloc.dart';

@freezed
class UserInfoEvent with _$UserInfoEvent {
  const factory UserInfoEvent.getUserInfo({
    required String userToken,
    required String deviceId,
    required String OTPNo,
  }) = _GetUserInfo;
}
