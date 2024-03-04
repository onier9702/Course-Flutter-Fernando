
import 'package:flutter/material.dart';

const List<Color> colorsList = [
  Colors.blue,
  Colors.red,
  Colors.purple,
  Colors.orange,
  Colors.pink,
];

class AppTheme {

  final int selectedColor;

  AppTheme({
    required this.selectedColor,
  }): assert(
    selectedColor >= 0 && selectedColor < colorsList.length,
    'Selected colors must be between 0 and ${colorsList.length}'
  );

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colorsList[selectedColor]
  );

}