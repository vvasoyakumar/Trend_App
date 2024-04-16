import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static String isVisitedIntro = "isVisitedIntro";
  static String unlockedProduct = "unlockedProduct";
  // static String identifier = "identifier";

  static SharedPreferences? prefs;

  static Future setInstance() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future saveString({required String key, required String value}) async {
    if (prefs == null) await setInstance();
    return await prefs?.setString(key, value);
  }

  static Future saveInt({required String key, required int value}) async {
    if (prefs == null) await setInstance();
    return await prefs?.setInt(key, value);
  }

  static Future saveBool({required String key, required bool value}) async {
    if (prefs == null) await setInstance();
    return await prefs?.setBool(key, value);
  }

  static Future<bool?> getBool({required String key}) async {
    if (prefs == null) await setInstance();
    return prefs?.getBool(key);
  }

  static Future<String?> getString({required String key}) async {
    if (prefs == null) await setInstance();
    return prefs?.getString(key);
  }

  static Future<int?> getInt({required String key}) async {
    if (prefs == null) await setInstance();
    return prefs?.getInt(key);
  }

  static Future delete({required String key}) async {
    if (prefs == null) await setInstance();
    return await prefs?.remove(key);
  }

  static Future<bool?> deleteAll() async {
    if (prefs == null) await setInstance();
    return await prefs?.clear();
  }
}
