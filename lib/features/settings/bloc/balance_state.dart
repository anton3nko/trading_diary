part of 'balance_bloc.dart';

@immutable
sealed class BalanceState extends Equatable {
  final double startingBalance;
  const BalanceState({required this.startingBalance});

  @override
  List<Object> get props => [startingBalance];
}

class BalanceInitialState extends BalanceState {
  const BalanceInitialState(double initialBalance)
      : super(startingBalance: initialBalance);
}

class BalanceAppliedState extends BalanceState {
  const BalanceAppliedState({required double balanceToApply})
      : super(startingBalance: balanceToApply);
}
