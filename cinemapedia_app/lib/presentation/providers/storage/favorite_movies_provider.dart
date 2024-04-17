import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/repositories/local_isar_repository.dart';
import 'package:cinemapedia_app/presentation/providers/storage/local_storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final favoriteMoviesProvider = StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {

  final localIsarRepo = ref.watch(localStorageRepositoryProvider);

  return StorageMoviesNotifier(
    localIsarRepository: localIsarRepo
  );
});

/* 
  {
    1: Movie,
    2: Movie,
    3: Movie,
  }
*/
class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {

  int page = 0;
  final LocalIsarRepository localIsarRepository;

  StorageMoviesNotifier({
    required this.localIsarRepository,
  }): super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localIsarRepository.loadMovies(limit: 10, offset: page * 2);
    page++;

    // Convert List to map cause movies is a list and we have a map in the provider
    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap}; // we are emiting a new state on this point

    return movies;
  }

  Future<void> toggleFavoriteMovie(Movie movie) async {
    // Here is the update on DB
    await localIsarRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    // Here is the update of the state
    if (isMovieInFavorites) {
      // Remove the movie from the state
      state.remove(movie.id);

      // Now an easy way to rebuild the state to make it appears on screen
      state = {...state};
    } else {
      // Here we insert the movie into the favorites state to make possible 
      // that the movie appears on list of favorites without make reload of the app
      state = {...state, movie.id: movie};
    }
  }

}
