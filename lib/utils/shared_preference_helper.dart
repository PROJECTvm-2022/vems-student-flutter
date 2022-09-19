import 'dart:convert';

import 'package:vems/config/index.dart';
import 'package:vems/data_models/user.dart';
import 'package:vems/data_models/video_data.dart';
import 'package:vems/extensions/theme_mode_extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const ACCESS_TOKEN_KEY = 'accessToken';
  static const USER_KEY = 'user';
  static const LOCATION_KEY = 'location';
  static const COLOR_KEY = 'color';
  static const THEME_MODE_KEY = 'theme_mode';
  static const VIDEO_HISTORY_KEY = 'video_key';
  static const FIRST_TIME_KEY = 'first_key';

  static SharedPreferences preferences;

  static void storeAccessToken(String accessToken) {
    preferences.setString(ACCESS_TOKEN_KEY, accessToken);
  }

  static String get accessToken => preferences.getString(ACCESS_TOKEN_KEY);

  static void logOut() {
    preferences.remove(ACCESS_TOKEN_KEY);
    preferences.remove(USER_KEY);
    preferences.remove(LOCATION_KEY);
    preferences.remove(COLOR_KEY);
    preferences.remove(THEME_MODE_KEY);
    preferences.remove(VIDEO_HISTORY_KEY);
  }

  static void clear() {
    preferences.clear();
  }

  static void storeUser({UserDatum user, String response}) {
    if (user != null)
      preferences.setString(USER_KEY, userDatumToJson(user));
    else {
      if (response == null || response.isEmpty)
        throw 'No value to store. Either a User object or a String response is required to store in preference.';
      else
        preferences.setString(USER_KEY, response);
    }
  }

  static UserDatum get user => preferences.getString(USER_KEY) == null
      ? null
      : userDatumFromJson(preferences.getString(USER_KEY));

  static void storeVideoHistory(List<StudentVideoDatum> videos) {
    if (videos != null) {
      preferences.setStringList(VIDEO_HISTORY_KEY,
          List<String>.from(videos.map((e) => studentVideoDatumToJson(e))));
    }
  }

  static List<StudentVideoDatum> get storedVideos =>
      preferences.containsKey(VIDEO_HISTORY_KEY)
          ? List<StudentVideoDatum>.from(preferences
              .getStringList(VIDEO_HISTORY_KEY)
              .map((e) => studentVideoDatumFromJson(e)))
          : [];

  static void storeLocation(List<double> coordinates) {
    preferences.setString(LOCATION_KEY,
        json.encode(List<dynamic>.from(coordinates.map((x) => x))));
  }

  static List<double> get location => preferences.containsKey(LOCATION_KEY)
      ? List<double>.from(json.decode(preferences.getString(LOCATION_KEY)))
          .map((x) => x.toDouble())
          .toList()
      : [
          85.8196623,
          20.3162543,
        ];

  static ColorThemes get themeColor =>
      preferences.get(COLOR_KEY) ?? ColorThemes.red;

  static void storeThemeColor(ColorThemes colorThemes) {
    preferences.setInt(COLOR_KEY, colorThemes.index);
  }

  static bool get isFirstTime => preferences.get(FIRST_TIME_KEY) ?? true;

  static void setFirstTime(bool value) {
    preferences.setBool(FIRST_TIME_KEY, value);
  }

  static ThemeMode get themeMode => preferences.get(THEME_MODE_KEY) == null
      ? ThemeMode.system
      : ThemeModeExtension.fromInt(preferences.get(THEME_MODE_KEY));

  static void storeThemeMode(ThemeMode themeMode) {
    preferences.setInt(THEME_MODE_KEY, themeMode.index);
  }
}
