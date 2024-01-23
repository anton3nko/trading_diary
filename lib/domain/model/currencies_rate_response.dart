class CurrenciesRateResponse {
  final bool success;
  final int timestamp;
  final String base;
  final String date;
  final List<CurrencyPairDTO> rates;

  CurrenciesRateResponse({
    required this.success,
    required this.timestamp,
    required this.base,
    required this.date,
    required this.rates,
  });

  factory CurrenciesRateResponse.fromJson(Map<String, dynamic> json) {
    var ratesJson = Map<String, num>.from(json['rates']);
    var rates =
        ratesJson.entries.map((e) => CurrencyPairDTO(e.key, e.value)).toList();

    return CurrenciesRateResponse(
      success: json['success'],
      timestamp: json['timestamp'],
      base: json['base'],
      date: json['date'],
      rates: rates,
    );
  }
}

class CurrencyPairDTO {
  final String currency;
  final num rate;

  CurrencyPairDTO(this.currency, this.rate);

  @override
  String toString() => 'CurrencyPairDTO(currency: $currency, rate: $rate)';
}
