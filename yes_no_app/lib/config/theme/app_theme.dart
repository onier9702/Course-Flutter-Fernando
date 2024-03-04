import 'package:flutter/material.dart';

const Color _customColor = Color(0x00F03030);
const List<Color> _colorTheme = [
  _customColor,
  Colors.blue,
  Colors.yellow,
  Colors.green,
  Colors.orange,
];

class AppTheme {

  final int selectedColor;

  AppTheme({
    this.selectedColor = 0
  }):assert(selectedColor >= 0 && selectedColor < _colorTheme.length, 'Colors must be between 0 and ${_colorTheme.length - 1}');

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorTheme[selectedColor],
      // brightness: Brightness.dark
    );
  }

}
