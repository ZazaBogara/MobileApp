import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorage {
  Future<void> saveData(String key, String value);
  Future<String?> getData(String key);
  Future<void> updateData(String key, String value);
  Future<void> deleteData(String key);
}

class SharedPreferencesStorage implements LocalStorage {
  @override
  Future<void> saveData(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<String?> getData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<void> updateData(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<void> deleteData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}