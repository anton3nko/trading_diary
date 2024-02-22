import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trading_diary/features/dashboard/widgets/app_pie_chart.dart';

final DateTime now = DateTime.now();
final DateTimeRange defaultRange = DateTimeRange(
    start: DateTime(now.year, now.month, 1),
    end: DateTime(now.year, now.month, now.day + 1));

class DashboardDataModel extends Equatable {
  final DateTimeRange dateRange;
  final List<Map<String, dynamic>> topStrategiesData;
  final List<Map<String, dynamic>> topCurrenciesData;
  final List<Map<String, dynamic>> transactionsData;
  final List<PieChartSection> topStrategiesPie;
  final List<PieChartSection> topCurrenciesPie;

  const DashboardDataModel({
    required this.dateRange,
    this.topStrategiesData = const [],
    this.topCurrenciesData = const [],
    this.transactionsData = const [],
    this.topStrategiesPie = const [],
    this.topCurrenciesPie = const [],
  });

  @override
  List<Object?> get props => [
        dateRange,
        topStrategiesData,
        topCurrenciesData,
        transactionsData,
        topStrategiesPie,
        topCurrenciesPie
      ];

  DashboardDataModel copyWith(
          {DateTimeRange? dateRange,
          List<Map<String, dynamic>>? topStrategiesData,
          List<Map<String, dynamic>>? topCurrenciesData,
          List<Map<String, dynamic>>? transactionsData,
          List<PieChartSection>? topStrategiesPie,
          List<PieChartSection>? topCurrenciesPie}) =>
      DashboardDataModel(
        dateRange: dateRange ?? this.dateRange,
        topStrategiesData: topStrategiesData ?? this.topStrategiesData,
        topCurrenciesData: topCurrenciesData ?? this.topCurrenciesData,
        transactionsData: transactionsData ?? this.transactionsData,
        topStrategiesPie: topStrategiesPie ?? this.topStrategiesPie,
        topCurrenciesPie: topCurrenciesPie ?? this.topCurrenciesPie,
      );

  String dateRangeToString() {
    final dateFormat = DateFormat.yMMMd();
    final String startDate = dateFormat.format(dateRange.start);
    final String endDate = dateFormat.format(dateRange.end);
    return '$startDate-$endDate';
  }
}
