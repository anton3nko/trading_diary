import 'package:trading_diary/domain/model/currencies_list_dto.dart';

abstract class BaseCurrencyRepo {
  Future<CurrenciesListDto> getCurrenciesList();
}
