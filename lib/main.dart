import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:trading_diary/data/api/currency_api.dart';
import 'package:trading_diary/styles/settings_provider.dart';
import 'internal/application.dart';

void main() {
  //CurrencyApi(token: 'f5c04ab3188fabd49034b54421ae3182').getCurrenciesList();
  runApp(
    ChangeNotifierProvider<SettingsProvider>(
      create: (_) => SettingsProvider()..initialize(),
      child: const Application(),
    ),
  );
}
