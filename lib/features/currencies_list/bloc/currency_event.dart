part of 'currency_bloc.dart';

sealed class CurrencyEvent extends Equatable {
  const CurrencyEvent();

  @override
  List<Object> get props => [];
}

class GetCurrenciesSymbolsEvent extends CurrencyEvent {}

class GetGurrencyRatesEvent extends CurrencyEvent {}
