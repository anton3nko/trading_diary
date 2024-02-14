import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_diary/services/shared_pref_service.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final PreferencesService preferenceService;

  BalanceBloc({required double initialBalance, required this.preferenceService})
      : super(BalanceInitialState(initialBalance)) {
    on<InitialBalanceEvent>(
      (event, emit) async {
        emit(
          BalanceAppliedState(
            balanceToApply: state.startingBalance,
          ),
        );
      },
    );

    on<ChangeStartingBalanceEvent>(
      (event, emit) async {
        double newStartingBalance = event.newStartingBalance;
        // SettingsModel newSettings =
        //     state.startingBalance.copyWith(startingBalance: newStartingBalance);
        await preferenceService.saveBalanceToPrefs(newStartingBalance);
        emit(BalanceAppliedState(balanceToApply: newStartingBalance));
      },
    );
    on<SavePreferencesEvent>(
      (event, emit) async {
        await preferenceService.saveBalanceToPrefs(state.startingBalance);
      },
    );
  }
}
