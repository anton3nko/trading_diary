part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class InitialSettingEvent extends SettingsEvent {
  const InitialSettingEvent();

  @override
  List<Object> get props => [];
}

class SwitchBrightnessEvent extends SettingsEvent {
  const SwitchBrightnessEvent();

  @override
  List<Object> get props => [];
}

class ChangePrimaryColorEvent extends SettingsEvent {
  final double newPrimaryColor;
  const ChangePrimaryColorEvent({required this.newPrimaryColor});

  @override
  List<Object> get props => [newPrimaryColor];
}

class ChangeStartingBalanceEvent extends SettingsEvent {
  final double newStartingBalance;
  const ChangeStartingBalanceEvent({required this.newStartingBalance});

  @override
  List<Object> get props => [newStartingBalance];
}

class SavePreferencesEvent extends SettingsEvent {
  const SavePreferencesEvent();

  @override
  List<Object> get props => [];
}
