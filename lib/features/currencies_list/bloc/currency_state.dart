part of 'currency_bloc.dart';

sealed class CurrencyState extends Equatable {
  const CurrencyState();

  @override
  List<Object> get props => [];
}

class CurrencyInitialState extends CurrencyState {}

class CurrencySymbolsLoading extends CurrencyState {}

class CurrencyRateLoading extends CurrencyState {}

class CurrencyRateData extends CurrencyState {
  final CurrenciesRateResponse data;

  const CurrencyRateData(this.data);

  @override
  List<Object> get props => [data];
}

class CurrencySymbolsData extends CurrencyState {
  final CurrencySymbolsResponse data;

  const CurrencySymbolsData(this.data);

  @override
  List<Object> get props => [data];
}

class CurrencyErrorState extends CurrencyState {
  final String message;

  const CurrencyErrorState(this.message);

  @override
  List<Object> get props => [message];
}
