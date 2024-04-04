import 'package:cinemapedia_app/presentation/screens/screens.dart';
import 'package:cinemapedia_app/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    // Shell Route
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const HomeView();
          },
          routes: [
            // Child routes from HomeView
            GoRoute(
              path: 'movie/:id',
              name: MovieDetailScreen.name,
              builder: (context, state) { 
                final movieId = state.pathParameters['id'] ?? 'no-id';

                return MovieDetailScreen(movieId: movieId);
              },
            ),

          ]
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesTab();
          },
        ),
      ]
    ),
    
    // Routes Parent-Children
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen(childView: FavoritesTab()),
    //   routes: [ // child routes

    //     GoRoute(
    //       path: 'movie/:id',
    //       name: MovieDetailScreen.name,
    //       builder: (context, state) { 
    //         final movieId = state.pathParameters['id'] ?? 'no-id';

    //         return MovieDetailScreen(movieId: movieId);
    //       },
    //     ),
        
    //   ],
    // ),
  ]
);