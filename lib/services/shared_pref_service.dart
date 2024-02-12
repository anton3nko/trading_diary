import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading_diary/domain/model/settings_model.dart';

//Сервис доступа к SharedPreferences(SP)
class PreferencesService {
  static const String _settingsKey = 'settingsString';
  SharedPreferences sharedPreferences;

  PreferencesService({required this.sharedPreferences});

  //Возвращает настройки для Settings Page из SP ?? настройки по-умолчанию
  SettingsModel readSettings() {
    const SettingsModel defaultSettings = SettingsModel(
      startingBalance: 1000,
    );
    String jsonString = sharedPreferences.getString(_settingsKey) ??
        jsonEncode(defaultSettings);
    log('jsonString : $jsonString');
    Map<String, dynamic> json = jsonDecode(jsonString);
    log('json: $json');
    SettingsModel initialSettings = SettingsModel.fromJson(json);
    return initialSettings;
  }

  //Сохраняет заданные настройки в SP
  Future<void> saveSettings(SettingsModel newSettings) async {
    await sharedPreferences.setString(_settingsKey, jsonEncode(newSettings));
  }
}

class ThemeProvider extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences? prefs;
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  ThemeProvider() {
    loadFromPrefs();
  }

  toggleTheme(bool isDarkTheme) {
    _darkTheme = isDarkTheme;
    saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = prefs?.getBool(key) ?? false;
    notifyListeners();
  }

  saveToPrefs() async {
    await _initPrefs();
    prefs?.setBool(key, darkTheme);
  }
}
