part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();
}

class TransactionInitialState extends TransactionState {
  @override
  List<Object> get props => [];
}

class DisplayTransactionsState extends TransactionState {
  final List<TradingTransaction> transactions;

  const DisplayTransactionsState({required this.transactions});
  @override
  List<Object> get props => [transactions];
}

class DisplaySpecificTransactionState extends TransactionState {
  final TradingTransaction transaction;

  const DisplaySpecificTransactionState({required this.transaction});
  @override
  List<Object> get props => [transaction];
}

class DisplayTopStrategiesState extends TransactionState {
  final List<Strategy> topStrategies;

  const DisplayTopStrategiesState({required this.topStrategies});

  @override
  List<Object?> get props => [topStrategies];
}
