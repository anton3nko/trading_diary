part of 'package:trading_diary/features/strategies/bloc/strategies_bloc.dart';

sealed class StrategyState extends Equatable {
  const StrategyState();
}

//TODO Вопрос, как в InitialState'е вызвать обработчик FetchAllStrategiesEvent'a
//для того, чтобы считать с БД дефолтную стратегию "None" и сохранить её
//в StrategyBloc.strategies;
class StrategyInitialState extends StrategyState {
  @override
  List<Object> get props => [];
}

class DisplayStrategiesState extends StrategyState {
  final List<Strategy> strategies;

  const DisplayStrategiesState({required this.strategies});
  @override
  List<Object> get props => [strategies];
}

class DisplaySpecificStrategyState extends StrategyState {
  final Strategy strategy;

  const DisplaySpecificStrategyState({required this.strategy});
  @override
  List<Object> get props => [strategy];
}
