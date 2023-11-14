import 'package:flutter/material.dart';
import 'package:trading_diary/domain/model/transaction.dart';

class Strategy {
  final String title;
  final Color strategyColor;

  //Для нахождения количества сделок по данной стратегии
  //TODO так норм?
  List<Transaction> transactions = [];

  Strategy({required this.title, required this.strategyColor});

  @override
  String toString() {
    return 'Strategy "$title" with $strategyColor';
  }
}
