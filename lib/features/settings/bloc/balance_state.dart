part of 'package:trading_diary/features/settings/bloc/balance_bloc.dart';

sealed class BalanceState extends Equatable {
  const BalanceState();
}

class InitialBalanceState extends BalanceState {
  const InitialBalanceState();

  @override
  List<Object> get props => [];
}

//Состояние отображения стартового баланса(Settings Page)
class DisplayStBalanceState extends BalanceState {
  final double startingBalance;
  const DisplayStBalanceState({required this.startingBalance});

  @override
  List<Object> get props => [startingBalance];
}

//Состояние отображения текущего баланса(Dashboard и Transactions page)
class DisplayCurBalanceState extends BalanceState {
  final double currentBalance;
  const DisplayCurBalanceState({required this.currentBalance});

  @override
  List<Object> get props => [currentBalance];
}
