import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  //! Initialize cache (call this in main.dart)
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  String? getDataString({required String key}) {
    return _sharedPreferences.getString(key);
  }

  //! this method to put data in local database using key
  static Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await _sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await _sharedPreferences.setDouble(key, value);
    } else {
      return false;
    }
  }

  //! this method to get data already saved in local database
  static dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  //! remove data using specific key
  static Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }

  //! this method to check if local database contains {key}
  static bool containsKey({required String key}) {
    return _sharedPreferences.containsKey(key);
  }

  static Future<bool> clearData() async {
    return await _sharedPreferences.clear();
  }

  //! this fun to put data in local data base using key
  static Future<bool> put({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await _sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return await _sharedPreferences.setBool(key, value);
    } else if (value is int) {
      return await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await _sharedPreferences.setDouble(key, value);
    } else {
      return false;
    }
  }
}