import 'package:docmehr/application/blocs/punch/punch_event.dart';
import 'package:docmehr/application/blocs/punch/punch_state.dart';
import 'package:docmehr/core/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/shared_preference.dart';

class PunchBloc extends Bloc<PunchEvent, PunchState> {
  PunchBloc() : super(PunchInLoading()) {
    on<UserPunchIn>(_onUserSetState);
  }

  // Stream<PunchInRunning> _onUserPunchIn(UserPunchRunning event, Emitter<PunchState> emit) async* {
  //   int? startTime = await SharedPrefs().getTimer();
  //   if (startTime != null) {
  //     int elapsed = await event.elapsedTime();
  //     print("-----elapsed------$elapsed");
  //     yield PunchInRunning(time: Duration(milliseconds: elapsed));
  //   } else {
  //     await event.punchIn();
  //     int elapsed = await event.elapsedTime();
  //     print("-----elapsed------$elapsed");
  //     yield PunchInRunning(time: Duration(milliseconds: elapsed));
  //   }
  // }

  // void _onUserPunchRunning(UserPunchRunning event, Emitter<PunchState> emit) {}
  //
  // void _onUserPunchOut(UserPunchOut event, Emitter<PunchState> emit) {}

  void _onUserSetState(UserPunchIn event, Emitter<PunchState> emit) async {
    emit(PunchInLoading());
    final prefs = SharedPrefs();
    try {
      PunchingState state = await prefs.getPunchState();
      if (state == PunchingState.punchIn) {
        emit(PunchInStart());
      } else if (state == PunchingState.punchInRunning) {
        String? startTime = await SharedPrefs().getTimer();
        print("-----startTime---$startTime");
        if (startTime != null) {
          String formattedTime = await event.elapsedTime();
          print("-----formattedTime------$formattedTime");
          emit(PunchInRunning(time: formattedTime));
        } else {
          emit(PunchInStart());
        }
      }
    } catch (e) {
      emit(PunchInError());
    }
  }
}
