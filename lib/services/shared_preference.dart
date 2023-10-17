import '../core/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<bool> setPunchState(PunchingState state) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("punchState", state.toString());
  }

  Future<PunchingState> getPunchState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? res = prefs.getString("punchState");
    if (res != null) {
      switch (res) {
        case "PunchingState.punchIn":
          return PunchingState.punchIn;
        case "PunchingState.punchInRunning":
          return PunchingState.punchInRunning;
        case "PunchingState.punchOut":
          return PunchingState.punchOut;
        default:
          return PunchingState.punchIn;
      }
    } else {
      return PunchingState.punchIn;
    }
  }

  Future<bool> setTimer(time) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("startTime", time);
  }

  Future<String?> getTimer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? res = prefs.getString("startTime");
    return res;
  }
}
