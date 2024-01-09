part of 'package:trading_diary/features/strategies/bloc/strategies_bloc.dart';

sealed class StrategyState extends Equatable {
  const StrategyState();
}

//TODO: Вопрос, как в InitialState'е вызвать обработчик FetchAllStrategiesEvent'a
//для того, чтобы считать с БД дефолтную стратегию "None" и сохранить её
//в StrategyBloc.strategies;
// Ответ: Зависит от того, что тебе именно  нужно. Если ты хочешь просто в InitialState иметь какую-то дефолтную стратегию, то сделай так, как я написал ниже (вариант 1)
// Если же тебе нужно инициализировать БД, то как вариант можешь сделать отдельный ивент InitialStrategyEvent, который будет вызываться при создании BlocProvider'a StrategyBloc
// Например в application.dart вызвать сразу необходимый ивент

///
/// TODO: Вариант 1
class StrategyInitialState extends StrategyState {
  final List<Strategy> strategies;
  const StrategyInitialState({required this.strategies});
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
