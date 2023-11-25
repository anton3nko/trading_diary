import 'package:flutter/material.dart';

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
  final Color? strategyColor;

  Strategy({this.id, required this.title, this.strategyColor});
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
        StrategyFields.color: strategyColor?.value,
      };

  @override
  String toString() {
    return 'Strategy "$title" with $strategyColor';
  }
}
