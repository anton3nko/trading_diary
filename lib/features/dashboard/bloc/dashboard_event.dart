part of 'package:trading_diary/features/dashboard/bloc/dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();
}

//Сбор данных для Dashboard(топ стратегий, топ валют, общее число сделок...) из БД
class FetchDashboardDataEvent extends DashboardEvent {
  const FetchDashboardDataEvent();

  @override
  List<Object> get props => [];
}

//Изменение значений фильтра по дате DateRangePicker()
class SetDateDashboardEvent extends DashboardEvent {
  final DateTime newBeginDate;
  final DateTime newEndDate;

  const SetDateDashboardEvent(
      {required this.newBeginDate, required this.newEndDate});

  @override
  List<Object> get props => [newBeginDate, newEndDate];
}
