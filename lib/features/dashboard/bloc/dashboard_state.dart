part of 'package:trading_diary/features/dashboard/bloc/dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  final DashboardDataModel dashboardData;
  const DashboardState({required this.dashboardData});

  @override
  List<Object> get props => [dashboardData];
}

class DashboardInitialState extends DashboardState {
  const DashboardInitialState(
      {required DashboardDataModel initialDashboardData})
      : super(dashboardData: initialDashboardData);
}

class NewDashboardDateApplied extends DashboardState {
  const NewDashboardDateApplied({required DashboardDataModel dataToApply})
      : super(dashboardData: dataToApply);
}

class DisplayDashboardDataState extends DashboardState {
  const DisplayDashboardDataState({required DashboardDataModel dataToDisplay})
      : super(dashboardData: dataToDisplay);
}
