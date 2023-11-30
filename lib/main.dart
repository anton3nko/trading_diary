import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:trading_diary/data/api/currency_api.dart';
import 'package:trading_diary/styles/theme_provider.dart';
import 'internal/application.dart';

void main() {
  //CurrencyApi(token: 'f5c04ab3188fabd49034b54421ae3182').getCurrenciesList();
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider()..initialize(),
      child: const Application(),
    ),
  );
}
