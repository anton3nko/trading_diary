import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';
import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/currency_pair.dart';
import 'package:trading_diary/data/repo/transactions_repo.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

//Вопрос. В правильные ли моменты отправляю ивенты
//FetchTransactionsEvent и CalculateTopStrategiesData
//для обновления данных на Dashboard, Transactions Page.
// Ответ: как правило ты подтягиваешь обновленные данные после создания или удаления какой-то сущности (транзакции, стратегии и т.д.)
// Ну в принципе же всё норм работает, я чекнул. После создания транзакции, она отображается на TransactionsPage, а после удаления - исчезает
// CalculateTopStrategies не чекал, но там тоже принцип схожий

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
