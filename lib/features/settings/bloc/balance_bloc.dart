import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_diary/data/repo/transactions_repo.dart';
import 'package:trading_diary/services/shared_pref_service.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final PreferencesService preferenceService;

  BalanceBloc({required double initialBalance, required this.preferenceService})
      : super(BalanceInitialState(initialBalance, 0.0)) {
    on<InitialBalanceEvent>(
      (event, emit) async {
        emit(
          BalanceAppliedState(
            balanceToApply: state.startingBalance,
            currentProfit: state.currentProfit,
          ),
        );
      },
    );
    on<CalculateCurrentProfitEvent>(
      (event, emit) async {
        final currentProfit = await TransactionsRepo.instance.calculateProfit();
        emit(BalanceAppliedState(
          balanceToApply: state.startingBalance,
          currentProfit: currentProfit,
        ));
      },
    );
    on<ChangeStartingBalanceEvent>(
      (event, emit) async {
        double newStartingBalance = event.newStartingBalance;
        await preferenceService.saveBalanceToPrefs(newStartingBalance);
        emit(BalanceAppliedState(
          balanceToApply: newStartingBalance,
          currentProfit: state.currentProfit,
        ));
      },
    );
    on<SavePreferencesEvent>(
      (event, emit) async {
        await preferenceService.saveBalanceToPrefs(state.startingBalance);
      },
    );
  }
}
