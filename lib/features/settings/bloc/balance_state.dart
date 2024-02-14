part of 'balance_bloc.dart';

@immutable
sealed class BalanceState extends Equatable {
  final SettingsModel settingsModel;
  const BalanceState({required this.settingsModel});

  @override
  List<Object> get props => [settingsModel];
}

class BalanceInitialState extends BalanceState {
  const BalanceInitialState(SettingsModel initialSettings)
      : super(settingsModel: initialSettings);
}

class BalanceAppliedState extends BalanceState {
  const BalanceAppliedState({required SettingsModel settingsToApply})
      : super(settingsModel: settingsToApply);
}
