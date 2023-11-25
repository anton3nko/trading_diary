import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';
import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/currency_pair.dart';
import 'package:trading_diary/services/database_service.dart';

part 'trading_transaction_event.dart';
part 'trading_transaction_state.dart';

class TradingTransactionBloc
    extends Bloc<TradingTransactionEvent, TradingTransactionState> {
  TradingTransactionBloc() : super(TradingTransactionInitialState()) {
    List<TradingTransaction> transactions = [];

    on<AddTradingTransactionEvent>(
      (event, emit) async {
        await DatabaseService.instance.createTradingTransaction(
          TradingTransaction(
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
    on<UpdateTradingTransactionEvent>(
      (event, emit) async {
        await DatabaseService.instance
            .updateTradingTransaction(transaction: event.transaction);
      },
    );
    on<FetchTradingTransactionsEvent>(
      (event, emit) async {
        transactions =
            await DatabaseService.instance.readAllTradingTransactions();
        emit(DisplayTradingTransactionsState(transactions: transactions));
      },
    );
    on<FetchSpecificTradingTransactionEvent>(
      (event, emit) async {
        TradingTransaction transaction =
            await DatabaseService.instance.readTradingTransaction(id: event.id);
        emit(DisplaySpecificTradingTransactionState(transaction: transaction));
      },
    );
    on<DeleteTradingTransactionEvent>(
      (event, emit) async {
        await DatabaseService.instance.deleteTradingTransaction(id: event.id);
        add(const FetchTradingTransactionsEvent());
      },
    );
  }
}
