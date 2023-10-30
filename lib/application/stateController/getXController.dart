import 'package:docmehr/core/enums.dart';
import 'package:docmehr/services/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Punchstate extends GetxController {
  Rx<PunchingState> state = PunchingState.punchIn.obs;
  Rx<String> formattedTime = "0".obs;
  void getState(String? loc, String? remark) async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (loc != null && remark != null) {
      SharedPrefs().setPunchState(PunchingState.punchInRunning);
      PunchingState? punchstate = await SharedPrefs().getPunchState();
      if (punchstate == PunchingState.punchInRunning) {
        final startTime = DateTime.now();
        await SharedPrefs().setTimer(startTime);
        state.value = PunchingState.punchInRunning;
        if (kDebugMode) {
          print(state.value);
        }
        String? getStartTime = await SharedPrefs().getTimer();
        if (kDebugMode) {
          print(getStartTime);
        }
        formattedTime.value = await elapsedTime();
      }
    }
  }

  Future<String> elapsedTime() async {
    String? startTime = await SharedPrefs().getTimer();
    DateTime time = DateTime.parse(startTime.toString());
    DateTime currentTime = DateTime.now();

    final timer = currentTime.difference(time);
    return timer.toString();
  }
}
