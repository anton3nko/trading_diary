import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:trading_diary/data/repo/transactions_repo.dart';

part 'package:trading_diary/features/settings/bloc/balance_event.dart';
part 'package:trading_diary/features/settings/bloc/balance_state.dart';

//bloc для отслеживания состояния баланса(стартовый баланс, текущий баланс)
class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  //TODO Не получается добавить инициализацию значения Starting Balance из SharedPreferences(SP),
  //т.к. работа с SP происходит асинхронно
  //Позже я планирую добавить в этот же блок настройки темы(dark mode/primary color)
  //Нашел чела, который решал подобную проблему. Пока разбираюсь, вникаю.
  //https://www.flutterclutter.dev/flutter/tutorials/using-bloc-pattern-with-service-layer/2020/1782/
  //На текущий момент подгрузка баланса из SP работает на Dashboard Page и криво
  //работает на Settings Page(при перезапуске приложения Starting Balance всегда равен = 1000)
  late double startingBalance;
  late double currentBalance;
  BalanceBloc() : super(const InitialBalanceState()) {
    startingBalance = 1000;
    currentBalance = 1000;
    on<InitBalanceEvent>((event, emit) async {
      log('InitBalanceEvent');
      final spref = await SharedPreferences.getInstance();
      startingBalance = spref.getDouble('startingBalance') ?? 1000;
      emit(DisplayStBalanceState(startingBalance: startingBalance));
    });
    on<DisplayStBalanceEvent>((event, emit) {
      emit(DisplayStBalanceState(startingBalance: startingBalance));
    });
    on<ChangeStBalanceEvent>((event, emit) async {
      startingBalance = event.newStBalance;
      final spref = await SharedPreferences.getInstance();
      await spref.setDouble('startingBalance', event.newStBalance);
      emit(DisplayStBalanceState(startingBalance: startingBalance));
    });
    on<DisplayCurBalanceEvent>((event, emit) async {
      double currentProfit = await TransactionsRepo.instance.calculateProfit();
      currentBalance += currentProfit;
      emit(DisplayCurBalanceState(currentBalance: currentBalance));
    });
  }
}
