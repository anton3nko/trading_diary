import 'package:flutter/material.dart';
import 'package:trading_diary/domain/model/transaction.dart';

const String strategyTable = 'strategies';

class StrategyFields {
  static final List<String> values = [id, title, color];

  static const String id = '_id';
  static const String title = 'title';
  static const String color = 'color';
}

class Strategy {
  final int? id;
  final String title;
  final Color strategyColor;

  //Для нахождения количества сделок по данной стратегии
  //TODO так норм? Или лучше для этого использовать запрос к базе?
  List<Transaction> transactions = [];

  Strategy({this.id, required this.title, required this.strategyColor});
  Strategy copy({
    int? id,
    String? title,
    Color? strategyColor,
  }) =>
      Strategy(
          id: id ?? this.id,
          title: title ?? this.title,
          strategyColor: strategyColor ?? this.strategyColor);

  static Strategy fromJson(Map<String, Object?> json) => Strategy(
        id: json[StrategyFields.id] as int?,
        title: json[StrategyFields.title] as String,
        strategyColor: Color(json[StrategyFields.color] as int).withOpacity(1),
      );

  Map<String, Object?> toJson() => {
        StrategyFields.id: id,
        StrategyFields.title: title,
        StrategyFields.color: strategyColor.value,
      };

  @override
  String toString() {
    return 'Strategy "$title" with $strategyColor';
  }
}
