import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trading_diary/data/repo/transactions_repo.dart';
import 'package:trading_diary/domain/model/dashboard_data_model.dart';

part 'package:trading_diary/features/dashboard/bloc/dashboard_event.dart';
part 'package:trading_diary/features/dashboard/bloc/dashboard_state.dart';

//Для обновления данных на DashboardPage создал отдельный bloc
// TODO: Здорово, но опять не хватает описания, что этот блок делает
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({
    required DashboardDataModel initialDashboardData,
  }) : super(
          DashboardInitialState(
            initialDashboardData: initialDashboardData,
          ),
        ) {
    on<FetchDashboardDataEvent>(
      (event, emit) async {
        var topStrategiesData = await TransactionsRepo.instance
            .calculateTopStrategies(state.dashboardData.dateRange.start,
                state.dashboardData.dateRange.end);
        var topCurrenciesData =
            await TransactionsRepo.instance.calculateTopCurrencies(
          state.dashboardData.dateRange.start,
          state.dashboardData.dateRange.end,
        );
        var dataToDisplay = state.dashboardData.copyWith(
          topStrategiesData: topStrategiesData,
          topCurrenciesData: topCurrenciesData,
        );
        final trData = dataToDisplay.calculateTrData();
        final topStrategiesPieData =
            dataToDisplay.calculateTopStrategiesPie(trData);
        emit(
          DisplayDashboardDataState(
            dataToDisplay: dataToDisplay.copyWith(
                transactionsData: trData,
                topStrategiesPieData: topStrategiesPieData),
          ),
        );
      },
    );
    on<SetDashboardDateEvent>(
      (event, emit) {
        final newDashboardData =
            state.dashboardData.copyWith(dateRange: event.newDateRange);
        emit(NewDashboardDateApplied(
          dataToApply: newDashboardData,
        ));
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
