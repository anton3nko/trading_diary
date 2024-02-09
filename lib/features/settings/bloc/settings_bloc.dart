import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_diary/domain/model/color_model.dart';
import 'package:trading_diary/domain/model/settings_model.dart';
import 'package:trading_diary/services/shared_pref_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final PreferencesService preferenceService;
  final _colors = const [
    ColorModel(index: 0.0, color: Colors.deepPurple, name: 'Deep Purple'),
    ColorModel(index: 1.0, color: Colors.lightGreenAccent, name: 'Green'),
    ColorModel(index: 2.0, color: Colors.yellowAccent, name: 'Yellow'),
    ColorModel(index: 3.0, color: Colors.white, name: 'White'),
  ];
  SettingsBloc(
      {required SettingsModel initialSettings, required this.preferenceService})
      : super(SettingsInitialState(initialSettings)) {
    on<InitialSettingEvent>((event, emit) async {
      emit(SettingsAppliedState(settingsToApply: state.settingsModel));
    });
    on<SwitchBrightnessEvent>((event, emit) async {
      final Brightness newBrightness =
          state.settingsModel.brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark;
      SettingsModel newSettings =
          state.settingsModel.copyWith(brightness: newBrightness);
      await preferenceService.saveSettings(newSettings);
      emit(SettingsAppliedState(settingsToApply: newSettings));
    });
    on<ChangePrimaryColorEvent>((event, emit) async {
      ColorModel newPrimaryColor = indexToPrimaryColor(event.newPrimaryColor);
      SettingsModel newSettings =
          state.settingsModel.copyWith(primaryColor: newPrimaryColor);
      await preferenceService.saveSettings(newSettings);
      emit(SettingsAppliedState(settingsToApply: newSettings));
    });
    on<ChangeStartingBalanceEvent>(
      (event, emit) async {
        double newStartingBalance = event.newStartingBalance;
        SettingsModel newSettings =
            state.settingsModel.copyWith(startingBalance: newStartingBalance);
        await preferenceService.saveSettings(newSettings);
        emit(SettingsAppliedState(settingsToApply: newSettings));
      },
    );
    on<SavePreferencesEvent>(
      (event, emit) async {
        await preferenceService.saveSettings(state.settingsModel);
      },
    );
  }
  ColorModel indexToPrimaryColor(double index) {
    return _colors.firstWhere((element) => element.index == index);
  }

  @override
  void onChange(Change<SettingsState> change) {
    super.onChange(change);
    log('$change');
  }
}
