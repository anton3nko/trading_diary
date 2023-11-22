import 'package:flutter/material.dart';
import 'package:trading_diary/domain/model/transaction.dart';

class CurrencyPair {
  final int? id;
  final String currencyPair;
  final Color currencyPairColor;

  List<Transaction> transaction = [];

  CurrencyPair(
      {this.id, required this.currencyPair, required this.currencyPairColor});
}
