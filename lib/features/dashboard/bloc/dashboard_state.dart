part of 'package:trading_diary/features/dashboard/bloc/dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();
}

class DashboardInitialState extends DashboardState {
  @override
  List<Object> get props => [];
}

class DisplayDashboardDataState extends DashboardState {
  final List<Map<String, dynamic>> topStrategiesData;
  final DateTime beginDate;
  final DateTime endDate;
  //final List<Map<String,dynamic>> topCurrenciesData;
  const DisplayDashboardDataState(
      {required this.topStrategiesData,
      required this.beginDate,
      required this.endDate});

  @override
  List<Object> get props => [topStrategiesData];
}
