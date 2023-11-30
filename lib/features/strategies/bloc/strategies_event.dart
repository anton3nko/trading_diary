part of 'package:trading_diary/features/strategies/bloc/strategies_bloc.dart';

sealed class StrategyEvent extends Equatable {
  const StrategyEvent();
}

class AddStrategyEvent extends StrategyEvent {
  final String title;
  final Color color;

  const AddStrategyEvent({required this.title, required this.color});

  @override
  List<Object?> get props => [title, color];
}

class UpdateStrategyEvent extends StrategyEvent {
  final Strategy strategy;
  const UpdateStrategyEvent({required this.strategy});

  @override
  List<Object?> get props => [strategy];
}

class FetchStrategiesEvent extends StrategyEvent {
  const FetchStrategiesEvent();

  @override
  List<Object?> get props => [];
}

class FetchSpecificStrategy extends StrategyEvent {
  final int id;
  const FetchSpecificStrategy({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteStrategyEvent extends StrategyEvent {
  final int id;
  const DeleteStrategyEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
