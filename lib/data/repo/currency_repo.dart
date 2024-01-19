import 'package:trading_diary/domain/model/currencies_rate_response.dart';
import 'package:trading_diary/domain/model/currency_symbols.dart';

abstract class BaseCurrencyRepo {
  Future<CurrenciesRateResponse>? getCurrenciesRate();

  Future<CurrencySymbolsResponse>? getCurrencySymbols();
}
