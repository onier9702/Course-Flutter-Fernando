import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:go_router/go_router.dart';

// Steps to reach the ConsumerStatefulWidget
// 1-) Convert the StatlessWidget to a StatefullWidget and this generate the state
// 2-) Convert the StatefullWidget to a ConsumerStatefullWidget
// 3-) Remove the _ to make the class not private
// 4-) Rename the class that extends the state to the same (for example FavoriteViewState)
// 5-) the @override of the class of the ConsumerStatefulWidget change for the name of the class extends the state
class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();

    // call our provider the first time in initState()
    // ref.read(favoriteMoviesProvider.notifier) // load the first page
    //   .loadNextPage();

    // This method include the ref.read(...) the same we wrote above
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;

    isLoading = true;
    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {

    // getting the movies and taking the values(Movie) and not the key(movieId) and convert them to list
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    // Display message if not favorite movies at that moment
    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary),
            Text('Ohh', style: TextStyle(fontSize: 30, color: colors.primary)),
            Text('There is not favorite movies!!', style: TextStyle(fontSize: 20, color: colors.primary)),
            const SizedBox(height: 20),
            FilledButton.tonal(
              onPressed: () => context.go('/home/0'),
              child: const Text('Start to aggregate now'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(movies: favoriteMovies, loadNextPage: loadNextPage),
    );
  }
}
