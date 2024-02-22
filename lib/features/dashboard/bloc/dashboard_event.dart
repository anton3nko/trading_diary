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
class SetDashboardDateEvent extends DashboardEvent {
  final DateTimeRange newDateRange;

  const SetDashboardDateEvent({required this.newDateRange});

  @override
  List<Object> get props => [newDateRange];
}
