import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_diary/domain/model/strategy.dart';
import 'package:trading_diary/services/database_service.dart';
import 'package:flutter/material.dart';

part 'strategies_event.dart';
part 'strategies_state.dart';

//TODO Верно ли то, что положил этот файл в Strategies->Data->bloc?
// Можешь просто в папку блок, отдельно Data не нужна
class StrategyBloc extends Bloc<StrategyEvent, StrategyState> {
  StrategyBloc() : super(StrategyInitialState()) {
    List<Strategy> strategies = [];

    on<AddStrategyEvent>(
      (event, emit) async {
        await DatabaseService.instance.createStrategy(
          Strategy(
            title: event.title,
            strategyColor: event.color,
          ),
        );
      },
    );

    on<UpdateStrategyEvent>((event, emit) async {
      await DatabaseService.instance.updateStrategy(
        strategy: event.strategy,
      );
    });

    on<FetchStrategiesEvent>((event, emit) async {
      strategies = await DatabaseService.instance.readAllStrategies();
      emit(DisplayStrategiesState(strategies: strategies));
    });

    on<FetchSpecificStrategy>((event, emit) async {
      Strategy strategy =
          await DatabaseService.instance.readStrategy(id: event.id);
      emit(DisplaySpecificStrategyState(strategy: strategy));
    });

    on<DeleteStrategyEvent>((event, emit) async {
      await DatabaseService.instance.deleteStrategy(id: event.id);
      add(const FetchStrategiesEvent());
    });
  }
}
