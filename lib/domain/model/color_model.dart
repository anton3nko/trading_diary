import 'package:flutter/material.dart';

class ColorModel {
  final double index;
  final Color color;
  final String name;

  const ColorModel(
      {required this.index, required this.color, required this.name});

  Map<String, dynamic> toJson() => {
        'colorIndex': index,
        'colorValue': color.value,
        'colorName': name,
      };

  static ColorModel fromJson(Map<String, dynamic> json) => ColorModel(
        index: json['colorIndex'],
        color: json['colorValue'],
        name: json['colorName'],
      );

  @override
  String toString() {
    return '$index $color $name';
  }
}
