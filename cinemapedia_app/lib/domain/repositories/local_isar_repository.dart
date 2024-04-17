import 'package:cinemapedia_app/domain/entities/movie.dart';


abstract class LocalIsarRepository {

  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
  
}
