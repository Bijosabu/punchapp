import 'package:docmehr/application/blocs/userData/user_event.dart';
import 'package:docmehr/application/blocs/userData/user_state.dart';
import 'package:docmehr/domain/models/userModel.dart';
import 'package:docmehr/sqflite_db/user_db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoading()) {
    on<LoadUser>(_onLoadUser);
  }

  void _onLoadUser(
    LoadUser event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      User? user = await UserDatabase.instance.readData(1);
      emit(UserLoaded(user: user!));
    } catch (e) {
      emit(UserError());
    }
  }
}
