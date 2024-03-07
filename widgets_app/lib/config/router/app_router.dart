import 'package:go_router/go_router.dart';
import 'package:widgets_app/presentation/screens/counter/counter_screen.dart';
import 'package:widgets_app/presentation/screens/screens.dart';

// Go Router config
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    GoRoute(
      name: HomeScreen.name,
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      name: ButtonsScreen.name,
      path: '/buttons',
      builder: (context, state) => const ButtonsScreen(),
    ),

    GoRoute(
      name: CardsScreen.name,
      path: '/cards',
      builder: (context, state) => const CardsScreen(),
    ),

    GoRoute(
      name: ProgressScreen.name,
      path: '/progress',
      builder: (context, state) => const ProgressScreen(),
    ),

    GoRoute(
      name: SnackbarScreen.name,
      path: '/snackbar',
      builder: (context, state) => const SnackbarScreen(),
    ),

    GoRoute(
      name: AnimatedScreen.name,
      path: '/animated',
      builder: (context, state) => const AnimatedScreen(),
    ),

    GoRoute(
      name: UiControlScreen.name,
      path: '/ui-controller',
      builder: (context, state) => const UiControlScreen(),
    ),

    GoRoute(
      name: InfiniteScrollScreen.name,
      path: '/infinite',
      builder: (context, state) => const InfiniteScrollScreen(),
    ),

    GoRoute(
      name: CounterScreen.name,
      path: '/counter',
      builder: (context, state) => const CounterScreen(),
    ),

    GoRoute(
      name: ThemeChangerScreen.name,
      path: '/theme-changer',
      builder: (context, state) => const ThemeChangerScreen(),
    ),

  ]
);
