import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/currency_pair.dart';
import 'package:trading_diary/domain/model/trading_transaction.dart';

//Необходимо при создании новой транзакции на TransactioAddPage()
class NewTransaction {
  TransactionType? transactionType;
  double? volume;
  CurrencyPair? currencyPair;
  DateTime? openDate;
  DateTime? closeDate;
  Strategy? mainStrategy;
  Strategy? secondaryStrategy;
  TimeFrame? timeFrame;
  double? profit;
  String? comment;

  NewTransaction({
    this.transactionType,
    this.volume,
    this.currencyPair,
    this.openDate,
    this.closeDate,
    this.mainStrategy,
    this.secondaryStrategy,
    this.timeFrame,
    this.profit,
    this.comment,
  });

  void resetNewTransaction() {
    transactionType = null;
    volume = null;
    currencyPair = null;
    openDate = null;
    closeDate = null;
    mainStrategy = null;
    secondaryStrategy = null;
    timeFrame = null;
    profit = null;
    comment = null;
  }
}
