import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading_diary/domain/model/settings_model.dart';
import 'package:trading_diary/domain/model/color_model.dart';

//Сервис доступа к SharedPreferences(SP)
class PreferencesService {
  static const String _settingsKey = 'settingsString';
  SharedPreferences sharedPreferences;

  PreferencesService({required this.sharedPreferences});

  //Возвращает настройки для Settings Page из SP ?? настройки по-умолчанию
  SettingsModel readSettings() {
    const SettingsModel defaultSettings = SettingsModel(
      brightness: Brightness.light,
      primaryColor: ColorModel(
        index: 0.0,
        color: Colors.deepPurple,
        name: 'Deep Purple',
      ),
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
