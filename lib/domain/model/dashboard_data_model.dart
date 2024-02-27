//import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardDataModel extends Equatable {
  final DateTimeRange dateRange;
  final List<Map<String, dynamic>> topStrategiesData;
  final List<Map<String, dynamic>> topCurrenciesData;
  final Map<String, dynamic> transactionsData;
  final List<Map<String, dynamic>> topStrategiesPieData;
  final List<Map<String, dynamic>> topCurrenciesPieData;

  const DashboardDataModel({
    required this.dateRange,
    this.topStrategiesData = const [],
    this.topCurrenciesData = const [],
    this.transactionsData = const {},
    this.topStrategiesPieData = const [],
    this.topCurrenciesPieData = const [],
  });

  @override
  List<Object?> get props => [
        dateRange,
        topStrategiesData,
        topCurrenciesData,
        transactionsData,
        topStrategiesPieData,
        topCurrenciesPieData
      ];

  DashboardDataModel copyWith(
          {DateTimeRange? dateRange,
          List<Map<String, dynamic>>? topStrategiesData,
          List<Map<String, dynamic>>? topCurrenciesData,
          Map<String, dynamic>? transactionsData,
          List<Map<String, dynamic>>? topStrategiesPieData,
          List<Map<String, dynamic>>? topCurrenciesPieData}) =>
      DashboardDataModel(
        dateRange: dateRange ?? this.dateRange,
        topStrategiesData: topStrategiesData ?? this.topStrategiesData,
        topCurrenciesData: topCurrenciesData ?? this.topCurrenciesData,
        transactionsData: transactionsData ?? this.transactionsData,
        topStrategiesPieData: topStrategiesPieData ?? this.topStrategiesPieData,
        topCurrenciesPieData: topCurrenciesPieData ?? this.topCurrenciesPieData,
      );

  String dateRangeToString() {
    final dateFormat = DateFormat.yMMMd();
    final String startDate = dateFormat.format(dateRange.start);
    final String endDate = dateFormat.format(dateRange.end);
    return '$startDate-$endDate';
  }

  Map<String, dynamic> calculateTrData() {
    Map<String, dynamic> trData = {};
    //List<PieChartSection> topStPie, topCurPie;
    double profit = 0.0;
    int totalCount = 0;
    int profitable = 0;
    for (var strategyData in topStrategiesData) {
      profit += double.parse(strategyData['profit']);
      totalCount += strategyData['total_count'] as int;
      profitable += strategyData['profitable'] as int;
    }
    trData['profit'] = profit;
    trData['total_count'] = totalCount;
    trData['profitable'] = profitable;
    //log('calculateTrData result = $trData');
    return trData;
  }

  List<Map<String, dynamic>> calculateTopStrategiesPie(
      Map<String, dynamic> trData) {
    List<Map<String, dynamic>> strategiesPieData = [];
    int index = 0;
    for (var strategyData in topStrategiesData) {
      double persentage = trData['total_count'] == 0
          ? 0
          : strategyData['total_count'] / trData['total_count'] * 100;
      Map<String, dynamic> result = {
        'index': index,
        'title': strategyData['title'],
        'color': strategyData['color'],
        'value': persentage,
      };
      strategiesPieData.add(result);
      index++;
    }
    //log('$strategiesPieData');
    return strategiesPieData;
  }

  bool isNotEmpty() {
    return transactionsData['total_count'] != 0 ? true : false;
  }
}
