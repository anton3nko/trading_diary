part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  final DateTimeRange dateRange;
  const TransactionState({required this.dateRange});

  @override
  List<Object> get props => [dateRange];
}

class TransactionInitialState extends TransactionState {
  const TransactionInitialState({required DateTimeRange initialDateRange})
      : super(dateRange: initialDateRange);
  @override
  List<Object> get props => [];
}

class DisplayTransactionsState extends TransactionState {
  final List<TradingTransaction> transactions;
  const DisplayTransactionsState(
      {required this.transactions, required DateTimeRange dateRange})
      : super(dateRange: dateRange);
  @override
  List<Object> get props => [transactions, dateRange];
}

class TransactionsDateAppliedState extends TransactionState {
  const TransactionsDateAppliedState({required DateTimeRange newDateRange})
      : super(dateRange: newDateRange);
}

// class DisplaySpecificTransactionState extends TransactionState {
//   final TradingTransaction transaction;

//   const DisplaySpecificTransactionState({required this.transaction,}):super(dateRange: this.dateRange);
//   @override
//   List<Object> get props => [transaction];
// }
