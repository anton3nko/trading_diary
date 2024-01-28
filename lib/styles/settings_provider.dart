import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading_diary/data/repo/transactions_repo.dart';

class SettingsProvider extends ChangeNotifier {
  String currentTheme = 'system';
  late int startingBalance;
  double currentProfit = 0;

  ThemeMode get themeMode {
    if (currentTheme == 'light') {
      return ThemeMode.light;
    } else if (currentTheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  //int get initialBalance => startingBalance;
// Добавил сохранение параметров темы в Shared Preferences
  changeTheme(String theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('theme', theme);

    currentTheme = theme;
    notifyListeners();
  }

  //Сохранение стартового баланса в SharedPreferences
  changeBalance(int newBalance) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('starting_balance', newBalance);

    startingBalance = newBalance;
    notifyListeners();
  }

  calculateProfit() async {
    double result = await TransactionsRepo.instance.calculateProfit();
    log(result.toString(), name: 'balance_profit');
    currentProfit = result;
    notifyListeners();
  }

//Инициализация темы из Shared Preferences ?? system
  initialize() async {
    log('initialize()', time: DateTime.now());
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    currentTheme = prefs.getString('theme') ?? 'system';
    startingBalance = prefs.getInt('starting_balance') ?? 1000;
    log(startingBalance.toString(), name: 'balance_init');
    notifyListeners();
  }
}
