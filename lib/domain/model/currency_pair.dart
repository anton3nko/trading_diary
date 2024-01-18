import 'package:flutter/material.dart';

class CurrencyPair {
  final int? id;
  final String currencyPairTitle;
  final Color? currencyPairColor;

  CurrencyPair(
      {this.id, required this.currencyPairTitle, this.currencyPairColor});
  @override
  String toString() {
    return 'CurrencyPair{ \'id\': $id, \'title\': $currencyPairTitle, \'color\': $currencyPairColor }}';
  }
}
