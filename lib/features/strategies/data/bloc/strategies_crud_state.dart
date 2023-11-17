part of 'package:trading_diary/features/strategies/data/bloc/strategies_crud_bloc.dart';

sealed class StrategyState extends Equatable {
  const StrategyState();
}

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
