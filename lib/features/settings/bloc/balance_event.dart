part of 'package:trading_diary/features/settings/bloc/balance_bloc.dart';

sealed class BalanceEvent extends Equatable {
  const BalanceEvent();
}

//Инициализация стартового баланса дефолтно = 1000
class InitBalanceEvent extends BalanceEvent {
  const InitBalanceEvent();

  @override
  List<Object> get props => [];
}

//Отобразить стартовый баланс
class DisplayStBalanceEvent extends BalanceEvent {
  final double startingBalance;
  const DisplayStBalanceEvent({required this.startingBalance});

  @override
  List<Object> get props => [startingBalance];
}

//Изменить стартовый баланс
class ChangeStBalanceEvent extends BalanceEvent {
  final double newStBalance;
  const ChangeStBalanceEvent({required this.newStBalance});

  @override
  List<Object> get props => [newStBalance];
}

//Отобразить текущий баланс с учетом сделок
class DisplayCurBalanceEvent extends BalanceEvent {
  const DisplayCurBalanceEvent();

  @override
  List<Object> get props => [];
}
