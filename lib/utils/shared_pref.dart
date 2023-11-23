import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPrefs {
  static String selectedArray = "selectedArray";

  AppSharedPrefs();

  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> get _instance async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance!;
  }

  // call this method from inState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static String getString(String key, [String? defValue]) {
    return _prefsInstance?.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String? value) async {
    var prefs = await _instance;
    return prefs.setString(key, value ?? "");
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value);
  }

  static Future<bool> setbool(String key, bool? value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value ?? false);
  }

  static bool getbool(String key) {
    return _prefsInstance?.getBool(key) ?? false;
  }

  static int getInt(String key, [int? defValue]) {
    return _prefsInstance?.getInt(key) ?? defValue ?? 0;
  }

  void removeAllSharedPrefData() async {
    var prefs = await _instance;
    prefs.clear();
  }
}
