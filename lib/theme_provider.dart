import 'package:flutter/material.dart';

//TODO в какую директорию убрать этот файл?
class ThemeProvider extends ChangeNotifier {
  String currentTheme = 'light';

  ThemeMode get themeMode {
    if (currentTheme == 'light') {
      return ThemeMode.light;
    } else if (currentTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  changeTheme(String theme) {
    currentTheme = theme;
    notifyListeners();
  }
}
