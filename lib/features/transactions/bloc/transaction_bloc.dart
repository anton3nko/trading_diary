import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';
import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/currency_pair.dart';
import 'package:trading_diary/data/repo/transactions_repo.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

//TODO Вопрос. В правильные ли моменты отправляю ивенты
//FetchTransactionsEvent и CalculateTopStrategiesData
//для обновления данных на Dashboard, Transactions Pages?
//Пока что обновляю данные в следующих моментах:
//- в DashboardPage()->build, если state = DashboardInitialState
//- в AppNavBar() при смене табов.
//- FetchTransactionEvent отправляю после добавления новой транзакции
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  List<TradingTransaction> transactions = [];
  //List<Map<String, dynamic>> topStrategiesData = [];

  TransactionBloc() : super(TransactionInitialState()) {
    on<AddTransactionEvent>(
      (event, emit) async {
        await TransactionsRepo.instance.createTransaction(
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
        await TransactionsRepo.instance
            .updateTransaction(transaction: event.transaction);
      },
    );
    on<FetchTransactionsEvent>(
      (event, emit) async {
        transactions = await TransactionsRepo.instance.readAllTransactions();
        emit(DisplayTransactionsState(transactions: transactions));
      },
    );
    on<FetchSpecificTransactionEvent>(
      (event, emit) async {
        TradingTransaction transaction =
            await TransactionsRepo.instance.readTransaction(id: event.id);
        emit(DisplaySpecificTransactionState(transaction: transaction));
      },
    );
    on<DeleteTransactionEvent>(
      (event, emit) async {
        await TransactionsRepo.instance.deleteTransaction(id: event.id);
        add(const FetchTransactionsEvent());
      },
    );
    // on<CalculateTopStrategiesEvent>(
    //   (event, emit) async {
    //     topStrategiesData =
    //         await TransactionsRepo.instance.calculateTopStrategies();
    //     emit(DisplayTopStrategiesState(topStrategiesData: topStrategiesData));
    //   },
    // );
  }
}
