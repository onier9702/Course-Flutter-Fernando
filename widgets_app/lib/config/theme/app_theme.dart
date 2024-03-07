
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
  final bool isDarkMode;

  AppTheme({
    this.selectedColor = 0,
    this.isDarkMode = false,
  }): assert(
    selectedColor >= 0 && selectedColor < colorsList.length,
    'Selected colors must be between 0 and ${colorsList.length}'
  );

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colorsList[selectedColor],
    brightness: isDarkMode ? Brightness.dark : Brightness.light,
  );

  AppTheme copyWith({int? selectedColor, bool? isDarkMode}) 
    => AppTheme(
      selectedColor: selectedColor ?? this.selectedColor,
      isDarkMode: isDarkMode ?? this.isDarkMode
    );

}