
import 'package:go_router/go_router.dart';
import 'package:push_notifications_app/presentation/screens/details_screen.dart';
import 'package:push_notifications_app/presentation/screens/home_screen.dart';

final appRouter = GoRouter(
  routes: [

    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/push-notification-details/:messageId',
      builder: (context, state) => DetailsScreen(
        pushMessageId: state.pathParameters['messageId'] ?? ''
      ),
    ),

  ]
);