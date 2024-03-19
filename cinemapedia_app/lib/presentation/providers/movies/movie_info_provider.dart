import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier,Map<String,Movie>>((ref) {

  final movieById = ref.watch(movieRepositoryProvider).getMovieById; // only the reference

  return MovieMapNotifier(
    getMovieByIdMethod: movieById
  );

});


/* 
  {
    '505642': Movie(),
    '505643': Movie(),
    '505644': Movie(),
  }

*/

typedef GetMovieCallback = Future<Movie>Function(String movieId); // just the definition

class MovieMapNotifier extends StateNotifier<Map<String,Movie>> {

  final GetMovieCallback getMovieByIdMethod;

  MovieMapNotifier({ // Constructor
    required this.getMovieByIdMethod
  }): super({});

  Future<void> loadMovie(String movieId) async {

    if (state[movieId] != null) return; // have this movie on cache
    // print('New http call.');
    final movie = await getMovieByIdMethod(movieId);
    state = {...state, movieId: movie};

  }

}
