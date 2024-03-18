import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// -------- Providers ---------

// Now Playing provider
final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

// Populars provider
final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopulars; // only the reference

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

// Top Rated provider
final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated; // only the reference

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

// Upcoming provider
final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {

  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming; // only the reference

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

// --------- Implementation --------
typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }): super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;
    
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    isLoading = false;
  }

}
