import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_app/domain/entities/movie.dart';

import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/presentation/delegates/search_movie_delegate.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox(width: 5),
              Text('Cinemapedia', style: titleStyle),

              const Spacer(), // to make an space between flex like website

              IconButton( // Method to Search
                icon: const Icon(Icons.search),
                onPressed: () {

                  // Getting the movieRepositoryProvider to have the reference to searchMovies
                  // final movieRepository = ref.read(movieRepositoryProvider);

                  // Now we have a provider that keeps the old movies and bring the new by the new query
                  final searchedMovies = ref.read(searchedMoviesProvider);
                  final searchQuery = ref.read(searchQueryProvider);

                  showSearch<Movie?>(
                    query: searchQuery,
                    context: context,
                    delegate: SearchMovieDelegate(
                      // SOLUTION without have the searchedMoviesProvider
                      // searchMovies: (query) {
                      //   // Update searchQueryProvider to the current query state
                      //   ref.read(searchQueryProvider.notifier).update((state) => query);
                      //   return movieRepository.searchMovies(query);
                      // },
                      initialMovies: searchedMovies, // this is the state<List<Movie>>
                      searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery
                    )
                  ).then((movie) {
                    if (movie == null) return;

                    // navigate to the id movie when click over one movie (function close from delegate was called)
                    context.push('/movie/${movie.id}');
                  });
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}
