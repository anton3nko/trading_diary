import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Сервис доступа к SharedPreferences(SP)
class PreferencesService {
  static const String _balanceKey = 'startingBalance';
  SharedPreferences sharedPreferences;

  PreferencesService({required this.sharedPreferences});

  //Возвращает Starting Balance для Settings Page из SP ?? Starting Balance по-умолчанию
  double loadBalanceFromPrefs() {
    const double defaultBalance = 1000;
    double initialBalance =
        sharedPreferences.getDouble(_balanceKey) ?? defaultBalance;
    return initialBalance;
  }

  //Сохраняет новый Starting Balance в SP
  Future<void> saveBalanceToPrefs(double newStartingBalance) async {
    await sharedPreferences.setDouble(_balanceKey, newStartingBalance);
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
