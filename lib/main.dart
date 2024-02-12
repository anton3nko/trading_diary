import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading_diary/domain/model/settings_model.dart';
import 'package:trading_diary/features/settings/bloc/settings_bloc.dart';
import 'package:trading_diary/services/shared_pref_service.dart';
import 'internal/application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final PreferencesService preferencesService = PreferencesService(
    sharedPreferences: prefs,
  );
  SettingsModel initialSettings = preferencesService.readSettings();
  runApp(
    BlocProvider(
      create: (context) => BalanceBloc(
        preferenceService: preferencesService,
        initialSettings: initialSettings,
      )..add(
          const InitialSettingEvent(),
        ),
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const Application(),
      ),
    ),
  );
}
