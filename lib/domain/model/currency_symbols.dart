// ignore_for_file: public_member_api_docs, sort_constructors_first
class CurrencySymbolsResponse {
  final bool success;
  final List<Currency>? symbols;
  final ErrorDTO? error;

  CurrencySymbolsResponse({required this.success, this.symbols, this.error});

  factory CurrencySymbolsResponse.fromJson(Map<String, dynamic> json) {
    var symbolsMap = json['symbols'] != null
        ? Map<String, String>.from(json['symbols'])
        : null;
    var symbolsList =
        symbolsMap?.entries.map((entry) => Currency.fromJson(entry)).toList();

    return CurrencySymbolsResponse(
      success: json['success'],
      symbols: symbolsList,
      error: json['error'] != null
          ? ErrorDTO.fromJson(Map<String, dynamic>.from(json['error']))
          : null,
    );
  }

  @override
  String toString() =>
      'CurrencySymbolsResponse(success: $success, symbols: $symbols, error: $error)';
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

class ErrorDTO {
  final int code;
  final String info;

  ErrorDTO({
    required this.code,
    required this.info,
  });

  factory ErrorDTO.fromJson(Map<String, dynamic> json) {
    return ErrorDTO(
      code: json['code'],
      info: json['info'],
    );
  }

  @override
  String toString() {
    return 'ErrorResponse(code: $code, info: $info)';
  }
}
