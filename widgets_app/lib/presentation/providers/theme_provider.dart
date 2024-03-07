import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

// List colors inmutable
final colorListProvider = Provider((ref) => colorsList);
// constant colorsList from app_theme.dart

// boolean
final isDarkModeProvider = StateProvider<bool>((ref) => false);

// int
final selectedColorProvider = StateProvider((ref) => 0);

// -------  IMPORTANT -----------
// An object of type AppTheme (customized)
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier()
);

// can be ThemeController
class ThemeNotifier extends StateNotifier<AppTheme> {

  // This mean: I need you to create the first instance of the class AppTheme
  // STATE = new AppTheme() the state is a new instance of AppTheme()
  ThemeNotifier(): super(AppTheme());

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorIndex(int colorIndex) {
    state = state.copyWith(selectedColor: colorIndex);
  }

  // ACCESS THE PROPERTIES WITH THE WORD state
  // void somethingToTest() {
  //   state.isDarkMode;
  //   state.selectedColor;
  // }



}
