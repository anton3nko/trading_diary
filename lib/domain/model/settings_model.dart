import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trading_diary/domain/model/color_model.dart';

//Модель для хранения настроек с Settings Page(Dark mode, Primary Color, Starting Balance)
class SettingsModel extends Equatable {
  final Brightness brightness;
  final ColorModel primaryColor;
  final double startingBalance;

  const SettingsModel({
    required this.brightness,
    required this.primaryColor,
    required this.startingBalance,
  });

  SettingsModel copyWith(
      {Brightness? brightness,
      ColorModel? primaryColor,
      double? startingBalance}) {
    return SettingsModel(
      brightness: brightness ?? this.brightness,
      primaryColor: primaryColor ?? this.primaryColor,
      startingBalance: startingBalance ?? this.startingBalance,
    );
  }

  Map<String, dynamic> toJson() => {
        'brightness': brightness == Brightness.dark ? true : false,
        ...primaryColor.toJson(),
        'startingBalance': startingBalance,
      };

  static SettingsModel fromJson(Map<String, dynamic> json) => SettingsModel(
        brightness:
            json['brightness'] == true ? Brightness.dark : Brightness.light,
        primaryColor: ColorModel(
            index: json['colorIndex'],
            color: Color(json['colorValue']).withOpacity(1),
            name: json['colorName']),
        startingBalance: json['startingBalance'],
      );

  @override
  String toString() {
    return '$brightness $primaryColor $startingBalance';
  }

  @override
  List<Object?> get props => [brightness, primaryColor, startingBalance];
}
