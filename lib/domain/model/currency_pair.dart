import 'package:flutter/material.dart';
import 'package:trading_diary/styles/styles.dart';

class CurrencyPair {
  static final List<CurrencyPair> currenciesList = [
    CurrencyPair(
      currencyPairTitle: 'USDCHF',
      currencyPairColor: Styles.kChartColors[0],
    ),
    CurrencyPair(
      currencyPairTitle: 'GBPUSD',
      currencyPairColor: Styles.kChartColors[1],
    ),
    CurrencyPair(
      currencyPairTitle: 'USDJPY',
      currencyPairColor: Styles.kChartColors[2],
    ),
    CurrencyPair(
      currencyPairTitle: 'EURUSD',
      currencyPairColor: Styles.kChartColors[3],
    ),
    CurrencyPair(
      currencyPairTitle: 'EURJPY',
      currencyPairColor: Styles.kChartColors[4],
    ),
    CurrencyPair(
      currencyPairTitle: 'EURGBP',
      currencyPairColor: Styles.kChartColors[5],
    ),
    CurrencyPair(
      currencyPairTitle: 'GBPJPY',
      currencyPairColor: Styles.kChartColors[6],
    ),
    CurrencyPair(
      currencyPairTitle: 'USDCAD',
      currencyPairColor: Styles.kChartColors[7],
    ),
    CurrencyPair(
      currencyPairTitle: 'EURCHF',
      currencyPairColor: Styles.kChartColors[8],
    ),
    CurrencyPair(
      currencyPairTitle: 'GBPCHF',
      currencyPairColor: Styles.kChartColors[9],
    ),
    CurrencyPair(
      currencyPairTitle: 'GBPCAD',
      currencyPairColor: Styles.kChartColors[10],
    ),
    CurrencyPair(
      currencyPairTitle: 'CADCHF',
      currencyPairColor: Styles.kChartColors[11],
    ),
  ];

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
