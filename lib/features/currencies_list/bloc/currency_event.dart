part of 'currency_bloc.dart';

sealed class CurrencyEvent extends Equatable {
  const CurrencyEvent();

  @override
  List<Object> get props => [];
}

class GetCurrenciesSymbolsEvent extends CurrencyEvent {}

class GetGurrencyRatesEvent extends CurrencyEvent {
  final String selectedCurrency;

  const GetGurrencyRatesEvent(this.selectedCurrency);

  @override
  List<Object> get props => [selectedCurrency];
}
