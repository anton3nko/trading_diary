import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trading_diary/theme_provider.dart';
import 'internal/application.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider()..initialize(),
      child: const Application(),
    ),
  );
}
