import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_diary/domain/model/settings_model.dart';
import 'package:trading_diary/services/shared_pref_service.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final PreferencesService preferenceService;

  BalanceBloc(
      {required SettingsModel initialSettings, required this.preferenceService})
      : super(BalanceInitialState(initialSettings)) {
    on<InitialBalanceEvent>(
      (event, emit) async {
        emit(
          BalanceAppliedState(
            settingsToApply: state.settingsModel,
          ),
        );
      },
    );

    on<ChangeStartingBalanceEvent>(
      (event, emit) async {
        double newStartingBalance = event.newStartingBalance;
        SettingsModel newSettings =
            state.settingsModel.copyWith(startingBalance: newStartingBalance);
        await preferenceService.saveSettings(newSettings);
        emit(BalanceAppliedState(settingsToApply: newSettings));
      },
    );
    on<SavePreferencesEvent>(
      (event, emit) async {
        await preferenceService.saveSettings(state.settingsModel);
      },
    );
  }
}
