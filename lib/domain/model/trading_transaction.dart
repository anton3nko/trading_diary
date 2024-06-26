import 'package:intl/intl.dart';
import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/domain/model/currency_pair.dart';

const String transactionTable = 'transactions_table';

class TransactionFields {
  static final List<String> values = [
    id,
    transactionType,
    volume,
    currencyPair,
    openDate,
    closeDate,
    mainStrategy,
    mainStrategyId,
    secondaryStrategy,
    secondaryStrategyId,
    timeFrame,
    profit,
    comment,
  ];

  static const String id = '_id';
  static const String transactionType = 'transactionType';
  static const String volume = 'volume';
  static const String currencyPair = 'currencyPair';
  static const String openDate = 'openDate';
  static const String closeDate = 'closeDate';
  static const String mainStrategy = 'mainStrategy';
  static const String mainStrategyId = 'mainStrategyId';
  static const String secondaryStrategy = 'secondaryStrategy';
  static const String secondaryStrategyId = 'secondaryStrategyId';
  static const String timeFrame = 'timeFrame';
  static const String profit = 'profit';
  static const String comment = 'comment';
}

enum TimeFrame {
  m1,
  m5,
  m15,
  m30,
  h1,
  h4,
  d1;

  String toJson() => name;
  static TimeFrame fromJson(String json) => values.byName(json);
}

enum TransactionType {
  buy,
  sell;

  String toJson() => name;
  static TransactionType fromJson(String json) => values.byName(json);
}

class TradingTransaction {
  final int? id;
  final TransactionType transactionType;
  final double volume;
  final CurrencyPair currencyPair;
  final DateTime openDate;
  DateTime? closeDate;
  final Strategy mainStrategy;
  final Strategy secondaryStrategy;
  final TimeFrame timeFrame;
  double? profit;
  String? comment;

  TradingTransaction({
    this.id,
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

  TradingTransaction copyWith({
    int? id,
    TransactionType? transactionType,
    double? volume,
    CurrencyPair? currencyPair,
    DateTime? openDate,
    DateTime? closeDate,
    Strategy? mainStrategy,
    Strategy? secondaryStrategy,
    TimeFrame? timeFrame,
    double? profit,
    String? comment,
  }) =>
      TradingTransaction(
        id: id ?? this.id,
        transactionType: transactionType ?? this.transactionType,
        volume: volume ?? this.volume,
        currencyPair: currencyPair ?? this.currencyPair,
        openDate: openDate ?? this.openDate,
        closeDate: closeDate ?? this.closeDate,
        mainStrategy: mainStrategy ?? this.mainStrategy,
        secondaryStrategy: secondaryStrategy ?? this.secondaryStrategy,
        timeFrame: timeFrame ?? this.timeFrame,
        profit: profit ?? this.profit,
        comment: comment ?? this.comment,
      );

  Map<String, Object?> toJson() => {
        TransactionFields.id: id,
        TransactionFields.transactionType: transactionType.toJson(),
        TransactionFields.volume: volume,
        TransactionFields.currencyPair: currencyPair.currencyPairTitle,
        TransactionFields.openDate: openDate.toString(),
        TransactionFields.closeDate: closeDate?.toString(),
        TransactionFields.mainStrategy: mainStrategy.title,
        TransactionFields.mainStrategyId: mainStrategy.id,
        TransactionFields.secondaryStrategy: secondaryStrategy.title,
        TransactionFields.secondaryStrategyId: secondaryStrategy.id,
        TransactionFields.timeFrame: timeFrame.toJson(),
        TransactionFields.profit: profit,
        TransactionFields.comment: comment,
      };

  static TradingTransaction fromJson(Map<String, dynamic> json) {
    TradingTransaction result;
    result = TradingTransaction(
      id: json[TransactionFields.id] as int?,
      transactionType: TransactionType.fromJson(
          json[TransactionFields.transactionType] as String),
      volume: json[TransactionFields.volume] as double,
      currencyPair: CurrencyPair(
          currencyPairTitle: json[TransactionFields.currencyPair] as String),
      openDate: DateTime.parse(json[TransactionFields.openDate] as String),
      closeDate: json[TransactionFields.closeDate].toString() == 'null'
          ? null
          : DateTime.parse(json[TransactionFields.closeDate].toString()),
      mainStrategy: Strategy(
          id: json[TransactionFields.mainStrategyId],
          title: json[TransactionFields.mainStrategy] as String),
      secondaryStrategy: Strategy(
          id: json[TransactionFields.secondaryStrategyId],
          title: json[TransactionFields.secondaryStrategy] as String),
      timeFrame:
          TimeFrame.fromJson(json[TransactionFields.timeFrame] as String),
      profit: json[TransactionFields.profit] as double?,
      comment: json[TransactionFields.comment] as String?,
    );

    return result;
  }

  String openDateToString() {
    return DateFormat('dd-MM-yyyy HH:mm').format(openDate);
  }

  String? closeDateToString() {
    return closeDate == null
        ? null
        : DateFormat('dd-MM-yyyy HH:mm').format(closeDate!);
  }
}
