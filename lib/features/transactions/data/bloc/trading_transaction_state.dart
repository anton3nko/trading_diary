part of 'trading_transaction_bloc.dart';

sealed class TradingTransactionState extends Equatable {
  const TradingTransactionState();
}

class TradingTransactionInitialState extends TradingTransactionState {
  @override
  List<Object> get props => [];
}

class DisplayTradingTransactionsState extends TradingTransactionState {
  final List<TradingTransaction> transactions;

  const DisplayTradingTransactionsState({required this.transactions});
  @override
  List<Object> get props => [transactions];
}

class DisplaySpecificTradingTransactionState extends TradingTransactionState {
  final TradingTransaction transaction;

  const DisplaySpecificTradingTransactionState({required this.transaction});
  @override
  List<Object> get props => [transaction];
}
