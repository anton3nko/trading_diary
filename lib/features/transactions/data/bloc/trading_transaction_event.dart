part of 'trading_transaction_bloc.dart';

sealed class TradingTransactionEvent extends Equatable {
  const TradingTransactionEvent();
}

class AddTradingTransactionEvent extends TradingTransactionEvent {
  final double volume;
  final CurrencyPair currencyPair;
  final DateTime openDate;
  DateTime? closeDate;
  final Strategy mainStrategy;
  final Strategy secondaryStrategy;
  final TimeFrame timeFrame;
  double? profit;
  String? comment;

  AddTradingTransactionEvent({
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

class UpdateTradingTransactionEvent extends TradingTransactionEvent {
  final TradingTransaction transaction;
  const UpdateTradingTransactionEvent({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

class FetchTradingTransactionsEvent extends TradingTransactionEvent {
  const FetchTradingTransactionsEvent();

  @override
  List<Object?> get props => [];
}

class FetchSpecificTradingTransactionEvent extends TradingTransactionEvent {
  final int id;
  const FetchSpecificTradingTransactionEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteTradingTransactionEvent extends TradingTransactionEvent {
  final int id;
  const DeleteTradingTransactionEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
