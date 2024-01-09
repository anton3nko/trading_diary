import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_diary/data/repo/transactions_repo.dart';

part 'package:trading_diary/features/dashboard/bloc/dashboard_event.dart';
part 'package:trading_diary/features/dashboard/bloc/dashboard_state.dart';

//Для обновления данных на DashboardPage создал отдельный bloc
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  List<Map<String, dynamic>> topStrategiesData = [];
  late DateTime startDate;
  late DateTime endDate;

  DashboardBloc() : super(DashboardInitialState()) {
    endDate = DateTime.now();
    startDate = DateTime(endDate.year, endDate.month, 1);

    on<FetchDashboardDataEvent>((event, emit) async {
      log('Dates:$startDate, $endDate', name: 'on<FetchDashboardDataEvent>');
      topStrategiesData =
          await TransactionsRepo.instance.calculateTopStrategies();
      emit(DisplayDashboardDataState(
        topStrategiesData: topStrategiesData,
        beginDate: startDate,
        endDate: endDate,
      ));
    });
  }
}
