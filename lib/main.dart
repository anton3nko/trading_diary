import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:trading_diary/data/api/currency_api.dart';
import 'package:trading_diary/styles/settings_provider.dart';
import 'internal/application.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trading_diary/features/settings/bloc/balance_bloc.dart';

void main() {
  runApp(
    ChangeNotifierProvider<SettingsProvider>(
      create: (_) => SettingsProvider()..initialize(),
      child: BlocProvider(
        create: (context) => BalanceBloc()..add(const InitBalanceEvent()),
        child: const Application(),
      ),
    ),
  );
}
