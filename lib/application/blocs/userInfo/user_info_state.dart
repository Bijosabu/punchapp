part of 'user_info_bloc.dart';

@freezed
class UserInfoState with _$UserInfoState {
  const factory UserInfoState({
    required UserInfoModel? userInfo,
    required bool isLoading,
    required bool isError,
  }) = _Initial;
  factory UserInfoState.initial() {
    return const UserInfoState(
      isError: false,
      isLoading: false,
      userInfo: null,
    );
  }
}
