// ignore_for_file: public_member_api_docs, sort_constructors_first
class CurrencySymbolsResponse {
  final bool success;
  final List<Currency> symbols;

  CurrencySymbolsResponse({required this.success, required this.symbols});

  factory CurrencySymbolsResponse.fromJson(Map<String, dynamic> json) {
    var symbolsMap = Map<String, String>.from(json['symbols']);
    var symbolsList =
        symbolsMap.entries.map((entry) => Currency.fromJson(entry)).toList();

    return CurrencySymbolsResponse(
      success: json['success'],
      symbols: symbolsList,
    );
  }

  @override
  String toString() =>
      'CurrencySymbolsResponse(success: $success, symbols: $symbols)';
}

class Currency {
  final String code;
  final String name;

  Currency({required this.code, required this.name});

  factory Currency.fromJson(MapEntry<String, String> entry) {
    return Currency(
      code: entry.key,
      name: entry.value,
    );
  }

  @override
  String toString() => 'Currency(code: $code, name: $name)';
}
