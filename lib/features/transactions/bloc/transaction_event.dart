part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();
}

class AddTransactionEvent extends TransactionEvent {
  final TransactionType transactionType;
  final double volume;
  final CurrencyPair currencyPair;
  final DateTime openDate;
  final DateTime? closeDate;
  final Strategy mainStrategy;
  final Strategy secondaryStrategy;
  final TimeFrame timeFrame;
  final double? profit;
  final String? comment;

  const AddTransactionEvent({
    required this.transactionType,
    required this.volume,
    required this.currencyPair,
    required this.openDate,
    this.closeDate,
    required this.mainStrategy,
    required this.secondaryStrategy,
    required this.timeFrame,
    this.profit,
    this.comment,
  });

  @override
  List<Object?> get props => [
        transactionType,
        volume,
        currencyPair,
        openDate,
        closeDate,
        mainStrategy,
        secondaryStrategy,
        timeFrame,
        profit,
        comment,
      ];
}

class UpdateTransactionEvent extends TransactionEvent {
  final TradingTransaction transaction;
  const UpdateTransactionEvent({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

class FetchTransactionsEvent extends TransactionEvent {
  const FetchTransactionsEvent();

  @override
  List<Object?> get props => [];
}

class FetchSpecificTransactionEvent extends TransactionEvent {
  final int id;
  const FetchSpecificTransactionEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteTransactionEvent extends TransactionEvent {
  final int id;
  const DeleteTransactionEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
