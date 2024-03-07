import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/router/app_router.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';


void main() {
  runApp(
    const ProviderScope( // state provider from riverpod
      child: MainApp()
    )
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {

    // already not necessary because StateNotofier have both
    // final isDarkMode = ref.watch(isDarkModeProvider);
    // final selectedColor = ref.watch(selectedColorProvider);

    final appTheme = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      title: 'Flutter Widgets',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),

      // This is not necessary when go_route is implemented
      // home: const HomeScreen(),

      // routes: { // basic routing, use go_router package instead
      //   '/buttons': (context) => const ButtonsScreen(),
      //   '/cards': (context) => const CardsScreen(),
      // },
    );
  }
}
