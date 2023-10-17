import 'package:bloc/bloc.dart';
import 'package:docmehr/domain/models/userInfoModel.dart';
import 'package:docmehr/infrastructure/userInfoRepo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
part 'user_info_event.dart';
part 'user_info_state.dart';
part 'user_info_bloc.freezed.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  final UserInfoRepo userInfoRepo;
  UserInfoBloc(this.userInfoRepo) : super(UserInfoState.initial()) {
    on<_GetUserInfo>((event, emit) async {
      emit(state.copyWith(
        isError: false,
        isLoading: true,
        userInfo: null,
      ));
      final data = await userInfoRepo.getUserInfo(
          event.userToken, event.deviceId, event.OTPNo);
      if (kDebugMode) {
        print(data);
      }
      emit(data.fold((failure) {
        return state.copyWith(
          isError: true,
          isLoading: false,
          userInfo: null,
        );
      }, (success) {
        return state.copyWith(
          isError: false,
          isLoading: false,
          userInfo: success,
        );
      }));
    });
  }
}
