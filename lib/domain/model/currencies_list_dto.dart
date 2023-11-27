class CurrenciesListDto {
  final bool success;
  final int timestamp;
  final String base;
  final String date;
  final Map<String, double> rates;

  CurrenciesListDto({
    required this.success,
    required this.timestamp,
    required this.base,
    required this.date,
    required this.rates,
  });

  factory CurrenciesListDto.fromJson(Map<String, dynamic> json) {
    return CurrenciesListDto(
      success: json['success'],
      timestamp: json['timestamp'],
      base: json['base'],
      date: json['date'],
      rates: Map<String, double>.from(
        json['rates'].map(
          (key, value) => MapEntry(
            key,
            value.toDouble(),
          ),
        ),
      ),
    );
  }
}
