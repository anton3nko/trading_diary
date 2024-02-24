part of 'balance_bloc.dart';

@immutable
sealed class BalanceEvent extends Equatable {
  const BalanceEvent();
}

//Ивент для инициализации bloc сразу же после его создания
class InitialBalanceEvent extends BalanceEvent {
  const InitialBalanceEvent();

  @override
  List<Object> get props => [];
}

//Ивент при редактировании Starting Balance на Settings Page
class ChangeStartingBalanceEvent extends BalanceEvent {
  final double newStartingBalance;
  const ChangeStartingBalanceEvent({required this.newStartingBalance});

  @override
  List<Object> get props => [newStartingBalance];
}

//Ивент для подсчета текущего баланса
class CalculateCurrentProfitEvent extends BalanceEvent {
  const CalculateCurrentProfitEvent();

  @override
  List<Object> get props => [];
}

//Ивент для сохранения текущих настроек с Settings Page в SharedPreferences
class SavePreferencesEvent extends BalanceEvent {
  const SavePreferencesEvent();

  @override
  List<Object> get props => [];
}
