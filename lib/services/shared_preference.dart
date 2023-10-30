import '../core/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

class SharedPrefs {
  final _getIt = GetIt.instance;
  SharedPreferences? _prefs;

  SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception("SharedPreferences has not been initialized.");
    }
    return _prefs!;
  }

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _getIt.registerSingleton<SharedPrefs>(this);
  }

  Future<bool> setPunchState(PunchingState state) async {
    final sharedPrefs = GetIt.instance<SharedPrefs>();
    final prefs = sharedPrefs.prefs;
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("punchState", state.toString());
  }

  Future<PunchingState> getPunchState() async {
    final sharedPrefs = GetIt.instance<SharedPrefs>();
    final prefs = sharedPrefs.prefs;
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
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
    final sharedPrefs = GetIt.instance<SharedPrefs>();
    final prefs = sharedPrefs.prefs;
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("startTime", time);
  }

  Future<String?> getTimer() async {
    final sharedPrefs = GetIt.instance<SharedPrefs>();
    final prefs = sharedPrefs.prefs;
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? res = prefs.getString("startTime");
    return res;
  }
}
