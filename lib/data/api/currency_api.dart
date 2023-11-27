import 'dart:convert';
import 'dart:developer';

import 'package:trading_diary/data/repo/currency_repo.dart';
import 'package:trading_diary/domain/model/currencies_list_dto.dart';
import 'package:http/http.dart' as http;

class CurrencyApi extends BaseCurrencyRepo {
  final String token;

  CurrencyApi({required this.token});

  @override
  Future<CurrenciesListDto> getCurrenciesList() async {
    try {
      final response = await http.get(
        Uri.parse(
          'http://data.fixer.io/api/latest?access_key=$token',
        ),
      );
      final decodedResponse = json.decode(response.body);
      log(decodedResponse.toString());
      return CurrenciesListDto.fromJson(decodedResponse);
    } catch (e) {
      throw Exception(e);
    }
  }
}
