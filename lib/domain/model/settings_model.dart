import 'package:equatable/equatable.dart';

//Модель для хранения настроек с Settings Page(Dark mode, Primary Color, Starting Balance)
class SettingsModel extends Equatable {
  final double startingBalance;

  const SettingsModel({
    required this.startingBalance,
  });

  SettingsModel copyWith({double? startingBalance}) {
    return SettingsModel(
      startingBalance: startingBalance ?? this.startingBalance,
    );
  }

  Map<String, dynamic> toJson() => {
        'startingBalance': startingBalance,
      };

  static SettingsModel fromJson(Map<String, dynamic> json) => SettingsModel(
        startingBalance: json['startingBalance'],
      );

  @override
  String toString() {
    return '$startingBalance';
  }

  @override
  List<Object?> get props => [startingBalance];
}
