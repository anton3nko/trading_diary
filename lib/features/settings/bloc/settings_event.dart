part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent extends Equatable {
  const SettingsEvent();
}

//Ивент для инициализации bloc сразу же после его создания
class InitialSettingEvent extends SettingsEvent {
  const InitialSettingEvent();

  @override
  List<Object> get props => [];
}

//Ивент при смене Dark Mode Switcher на Settings Page
class SwitchBrightnessEvent extends SettingsEvent {
  const SwitchBrightnessEvent();

  @override
  List<Object> get props => [];
}

//Ивент при смене Primary Color Slider на Settings Page
class ChangePrimaryColorEvent extends SettingsEvent {
  final double newPrimaryColor;
  const ChangePrimaryColorEvent({required this.newPrimaryColor});

  @override
  List<Object> get props => [newPrimaryColor];
}

//Ивент при редактировании Starting Balance на Settings Page
class ChangeStartingBalanceEvent extends SettingsEvent {
  final double newStartingBalance;
  const ChangeStartingBalanceEvent({required this.newStartingBalance});

  @override
  List<Object> get props => [newStartingBalance];
}

//Ивент для сохранения текущих настроек с Settings Page в SharedPreferences
class SavePreferencesEvent extends SettingsEvent {
  const SavePreferencesEvent();

  @override
  List<Object> get props => [];
}
