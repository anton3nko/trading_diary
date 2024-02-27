part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();
}

//Ивент при добавлении новой транзакции
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

//Ивент при редактировании конкретной транзакции
class UpdateTransactionEvent extends TransactionEvent {
  final TradingTransaction transaction;
  const UpdateTransactionEvent({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

//Ивент для считывания из БД данных по всем имеющимся транзакциям
class FetchTransactionsEvent extends TransactionEvent {
  const FetchTransactionsEvent();

  @override
  List<Object?> get props => [];
}

//Ивент при изменении временного периода в DateRangePicker()
class SetTransactionsDateEvent extends TransactionEvent {
  final DateTimeRange newDateRange;

  const SetTransactionsDateEvent({required this.newDateRange});

  @override
  List<Object> get props => [newDateRange];
}

//Ивент для отображения данных по конкретной транзакции
class FetchSpecificTransactionEvent extends TransactionEvent {
  final int id;
  const FetchSpecificTransactionEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

//Ивент при удалении транзакции
class DeleteTransactionEvent extends TransactionEvent {
  final int id;
  const DeleteTransactionEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
