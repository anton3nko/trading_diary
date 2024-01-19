import 'dart:convert';

import 'package:trading_diary/data/repo/currency_repo.dart';
import 'package:trading_diary/domain/model/currencies_rate_response.dart';
import 'package:http/http.dart' as http;
import 'package:trading_diary/domain/model/currency_symbols.dart';

class CurrencyApi extends BaseCurrencyRepo {
  final String token;

  CurrencyApi({required this.token});

  // Запрос списка валют
  @override
  Future<CurrencySymbolsResponse>? getCurrencySymbols() async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://data.fixer.io/api/symbols?access_key=$token',
        ),
      );
      final decodedResponse = json.decode(response.body);
      return CurrencySymbolsResponse.fromJson(decodedResponse);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Запрос курса валют по выбранной паре. Базовая валюта - евро
  @override
  Future<CurrenciesRateResponse>? getCurrenciesRate() async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://data.fixer.io/api/latest?access_key=$token',
        ),
      );
      final decodedResponse = json.decode(response.body);
      return CurrenciesRateResponse.fromJson(decodedResponse);
    } catch (e) {
      throw Exception(e);
    }
  }
}
