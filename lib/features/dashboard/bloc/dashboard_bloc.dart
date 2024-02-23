import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trading_diary/data/repo/transactions_repo.dart';
import 'package:trading_diary/domain/model/dashboard_data_model.dart';

part 'package:trading_diary/features/dashboard/bloc/dashboard_event.dart';
part 'package:trading_diary/features/dashboard/bloc/dashboard_state.dart';

//Для обновления данных на DashboardPage создал отдельный bloc
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required DashboardDataModel initialDashboardData})
      : super(DashboardInitialState(
          initialDashboardData: initialDashboardData,
        )) {
    on<FetchDashboardDataEvent>((event, emit) async {
      var topStrategiesData = await TransactionsRepo.instance
          .calculateTopStrategies(state.dashboardData.dateRange.start,
              state.dashboardData.dateRange.end);
      await TransactionsRepo.instance.calculateTopCurrencies(
        state.dashboardData.dateRange.start,
        state.dashboardData.dateRange.end,
      );
      final dataToDisplay =
          state.dashboardData.copyWith(topStrategiesData: topStrategiesData);
      emit(DisplayDashboardDataState(
        dataToDisplay: dataToDisplay,
      ));
    });
    on<SetDashboardDateEvent>(
      (event, emit) {
        final newDashboardData =
            state.dashboardData.copyWith(dateRange: event.newDateRange);
        emit(NewDashboardDateApplied(dataToApply: newDashboardData));
        add(const FetchDashboardDataEvent());
      },
    );
  }

  @override
  void onChange(Change<DashboardState> change) {
    //log('$change');
    super.onChange(change);
  }
}
