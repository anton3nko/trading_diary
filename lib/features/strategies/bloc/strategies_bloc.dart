import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trading_diary/domain/model/strategy.dart';
import 'package:flutter/material.dart';
import 'package:trading_diary/data/repo/strategies_repo.dart';

part 'package:trading_diary/features/strategies/bloc/strategies_event.dart';
part 'package:trading_diary/features/strategies/bloc/strategies_state.dart';

class StrategyBloc extends Bloc<StrategyEvent, StrategyState> {
  List<Strategy> strategies = [];

  StrategyBloc()
      : super(
          StrategyInitialState(
            // TODO: Вариант 1: Вот тут ты можешь сделать так, чтобы в InitialState была какая-то дефолтная стратегия (вариант 1)
            strategies: [
              Strategy(
                title: 'None',
                id: 0,
              )
            ],
          ),
        ) {
    // TODO: Вариант 2
    on<InitialStrategyEvent>((event, emit) async {
      // Fetch all necessary data from DB
    });
    on<AddStrategyEvent>(
      (event, emit) async {
        await StrategiesRepo.instance.createStrategy(
          Strategy(
            title: event.title,
            strategyColor: event.color,
          ),
        );
      },
    );

    on<UpdateStrategyEvent>((event, emit) async {
      await StrategiesRepo.instance.updateStrategy(
        strategy: event.strategy,
      );
    });

    on<FetchStrategiesEvent>((event, emit) async {
      strategies = await StrategiesRepo.instance.readAllStrategies();
      emit(DisplayStrategiesState(strategies: strategies));
    });

    on<FetchSpecificStrategy>((event, emit) async {
      Strategy strategy =
          await StrategiesRepo.instance.readStrategy(id: event.id);
      emit(DisplaySpecificStrategyState(strategy: strategy));
    });

    on<DeleteStrategyEvent>((event, emit) async {
      await StrategiesRepo.instance.deleteStrategy(id: event.id);
      add(const FetchStrategiesEvent());
    });
  }

  List<Strategy> get strategyList => strategies;
}
