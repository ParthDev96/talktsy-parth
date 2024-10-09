import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talktsy/config/app_shared_preference_keys.dart';
import 'package:talktsy/models/user_profile.dart';

class SharedPrefsHelper {
  static Future<SharedPreferences> _getInstance() async {
    return await SharedPreferences.getInstance();
  }

  // Save a String value
  static Future<void> saveString(String key, String value) async {
    final SharedPreferences prefs = await _getInstance();
    await prefs.setString(key, value);
  }

  // Retrieve a String value
  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = await _getInstance();
    return prefs.getString(key);
  }

  // Remove a value
  static Future<void> remove(String key) async {
    final SharedPreferences prefs = await _getInstance();
    await prefs.remove(key);
  }

  // Clear all values
  static Future<void> clear() async {
    final SharedPreferences prefs = await _getInstance();
    await prefs.clear();
  }

  static Future<void> saveObject(String key, dynamic data) async {
    SharedPreferences prefs = await _getInstance();
    String jsonString = jsonEncode(data);
    await prefs.setString(key, jsonString);
  }

  static Future<dynamic> getObject(String key) async {
    SharedPreferences prefs = await _getInstance();
    String? jsonString = prefs.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }
}

class SharedPreferenceUserProfile {
  // Save UserProfile to SharedPreferences
  static Future<void> saveUserProfile(UserProfile profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        AppSharedPreferenceKeys.profileData, profile.toJsonString());
  }

  // Retrieve UserProfile from SharedPreferences
  static Future<UserProfile?> getUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(AppSharedPreferenceKeys.profileData);
    if (jsonString != null) {
      var profile = UserProfile.fromJsonString(jsonString);
      return profile;
    }
    return null;
  }

  // Clear UserProfile from SharedPreferences
  static Future<void> clearUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppSharedPreferenceKeys.profileData);
  }
}
