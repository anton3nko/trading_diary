import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trading_diary/data/repo/transactions_repo.dart';
import 'package:trading_diary/domain/model/dashboard_data_model.dart';

part 'package:trading_diary/features/dashboard/bloc/dashboard_event.dart';
part 'package:trading_diary/features/dashboard/bloc/dashboard_state.dart';

//Для обновления данных на DashboardPage создал отдельный bloc
/*
Состояние данного bloc'a содержит информацию(см. DashboardDataModel) для виджетов Dashobard Page для заданного временного промежутка:
- временной интервал;
- данные для круговой диаграммы;
- профит, общее число сделок, прибыльные сделки;
- топ стратегий;
- топ валют.
*/
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  //В initialDashboardData передаём начальный временной интервал(с 1 числа текущего месяца по сейчас)
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
        final topCurrenciesPieData =
            dataToDisplay.calculateTopCurrenciesPie(trData);
        emit(
          DisplayDashboardDataState(
            dataToDisplay: dataToDisplay.copyWith(
              transactionsData: trData,
              topStrategiesPieData: topStrategiesPieData,
              topCurrenciesPieData: topCurrenciesPieData,
            ),
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
