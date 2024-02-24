part of 'balance_bloc.dart';

@immutable
sealed class BalanceState extends Equatable {
  final double startingBalance;
  final double currentProfit;
  const BalanceState({
    required this.startingBalance,
    required this.currentProfit,
  });

  @override
  List<Object> get props => [startingBalance, currentProfit];

  double get currentBalance {
    final curBal = startingBalance + currentProfit;
    //log('$startingBalance + $currentProfit =  $curBal');
    return curBal;
  }
}

class BalanceInitialState extends BalanceState {
  const BalanceInitialState(double initialBalance, double currentProfit)
      : super(
          startingBalance: initialBalance,
          currentProfit: currentProfit,
        );
}

class BalanceAppliedState extends BalanceState {
  const BalanceAppliedState(
      {required double balanceToApply, required double currentProfit})
      : super(startingBalance: balanceToApply, currentProfit: currentProfit);
}
