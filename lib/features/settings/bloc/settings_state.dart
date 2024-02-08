part of 'settings_bloc.dart';

@immutable
sealed class SettingsState extends Equatable {
  final SettingsModel settingsModel;
  const SettingsState({required this.settingsModel});

  @override
  List<Object> get props => [settingsModel];
}

class SettingsInitialState extends SettingsState {
  const SettingsInitialState(SettingsModel settingsToInit)
      : super(settingsModel: settingsToInit);
}

class SettingsAppliedState extends SettingsState {
  const SettingsAppliedState({required SettingsModel settingsToApply})
      : super(settingsModel: settingsToApply);
}
