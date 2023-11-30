import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';
import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/currency_pair.dart';
import 'package:trading_diary/services/database_service.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitialState()) {
    List<TradingTransaction> transactions = [];

    on<AddTransactionEvent>(
      (event, emit) async {
        await DatabaseService.instance.createTransaction(
          TradingTransaction(
              transactionType: event.transactionType,
              volume: event.volume,
              currencyPair: event.currencyPair,
              openDate: event.openDate,
              closeDate: event.closeDate,
              mainStrategy: event.mainStrategy,
              secondaryStrategy: event.secondaryStrategy,
              timeFrame: event.timeFrame,
              profit: event.profit,
              comment: event.comment),
        );
      },
    );
    on<UpdateTransactionEvent>(
      (event, emit) async {
        await DatabaseService.instance
            .updateTransaction(transaction: event.transaction);
      },
    );
    on<FetchTransactionsEvent>(
      (event, emit) async {
        transactions = await DatabaseService.instance.readAllTransactions();
        emit(DisplayTransactionsState(transactions: transactions));
      },
    );
    on<FetchSpecificTransactionEvent>(
      (event, emit) async {
        TradingTransaction transaction =
            await DatabaseService.instance.readTransaction(id: event.id);
        emit(DisplaySpecificTransactionState(transaction: transaction));
      },
    );
    on<DeleteTransactionEvent>(
      (event, emit) async {
        await DatabaseService.instance.deleteTransaction(id: event.id);
        add(const FetchTransactionsEvent());
      },
    );
  }
}
