import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:trading_diary/data/repo/transactions_repo.dart';

part 'package:trading_diary/features/settings/bloc/balance_event.dart';
part 'package:trading_diary/features/settings/bloc/balance_state.dart';

//bloc для отслеживания состояния баланса(стартовый баланс, текущий баланс)
class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  late double startingBalance;
  late double currentBalance;
  BalanceBloc() : super(const InitialBalanceState()) {
    startingBalance = 1000;
    currentBalance = 1000;
    on<InitBalanceEvent>((event, emit) {
      log('InitBalanceEvent');

      emit(DisplayStBalanceState(startingBalance: startingBalance));
    });
    on<DisplayStBalanceEvent>((event, emit) {
      emit(DisplayStBalanceState(startingBalance: startingBalance));
    });
    on<ChangeStBalanceEvent>((event, emit) {
      startingBalance = event.newStBalance;
      emit(DisplayStBalanceState(startingBalance: startingBalance));
    });
    on<DisplayCurBalanceEvent>((event, emit) async {
      double currentProfit = await TransactionsRepo.instance.calculateProfit();
      currentBalance += currentProfit;
      emit(DisplayCurBalanceState(currentBalance: currentBalance));
    });
  }
}
