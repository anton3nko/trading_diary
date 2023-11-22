import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/currency_pair.dart';

class Transaction {
  final int? id;
  final double volume;
  final CurrencyPair currencyPair;
  final DateTime openDate;
  //TODO необязательные поля объявлять таким образом?
  DateTime? closeDate;
  final Strategy mainStrategy;
  final Strategy secondaryStrategy;
  //Временной интервал графика М1, М5, М15, М30, H1, H4, D1
  //TODO Вынести в отдельный класс?
  final String timeframe;
  double? profit;

  Transaction({
    this.id,
    required this.volume,
    required this.currencyPair,
    required this.openDate,
    this.closeDate,
    required this.mainStrategy,
    required this.secondaryStrategy,
    required this.timeframe,
    this.profit,
  });
}
