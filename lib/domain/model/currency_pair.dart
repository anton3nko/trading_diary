import 'package:flutter/material.dart';
import 'package:trading_diary/domain/model/transaction.dart';

class CurrencyPair {
  final String currencyPair;
  final Color currencyPairColor;

  List<Transaction> transaction = [];

  CurrencyPair({required this.currencyPair, required this.currencyPairColor});
}
