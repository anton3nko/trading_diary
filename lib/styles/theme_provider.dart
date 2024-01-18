import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  String currentTheme = 'system';
  double startingBalance = 1000;

  ThemeMode get themeMode {
    if (currentTheme == 'light') {
      return ThemeMode.light;
    } else if (currentTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  double get balance => startingBalance;
// Добавил сохранение параметров темы в Shared Preferences
  changeTheme(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('theme', theme);

    currentTheme = theme;
    notifyListeners();
  }

  //
  changeBalance(double newBalance) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('balance', newBalance);
    startingBalance = newBalance;
    notifyListeners();
  }

//Инициализация темы из Shared Preferences ?? system
  initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    currentTheme = prefs.getString('theme') ?? 'system';
    startingBalance = prefs.getDouble('balance') ?? 1000;

    notifyListeners();
  }
}
