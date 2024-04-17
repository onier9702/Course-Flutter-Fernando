import 'package:cinemapedia_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final String pageIndex = state.pathParameters['page'] ?? '0';

        return HomeScreen(pageIndex: int.parse(pageIndex));
      },
      routes: [ // child routes

        GoRoute(
          path: 'movie/:id',
          name: MovieDetailScreen.name,
          builder: (context, state) { 
            final movieId = state.pathParameters['id'] ?? 'no-id';

            return MovieDetailScreen(movieId: movieId);
          },
        ),
        
      ],
    ),

    // Redirect
    GoRoute(
      path: '/',
      // _ => context and __ => state
      redirect: ( _ , __ ) => '/home/0',
    )
  ]
);