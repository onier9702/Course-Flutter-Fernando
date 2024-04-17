import 'package:isar/isar.dart';

import 'package:cinemapedia_app/domain/datasources/local_isar_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatasource extends LocalIsarDatasource {

  late Future<Isar> db; 

  IsarDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [MovieSchema], 
        directory: dir.path,
        inspector: true
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;
    final Movie? isFavoriteMovie = await isar.movies
      .filter()
      .idEqualTo(movieId)
      .findFirst();

    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;

    return isar.movies.where()
      .offset(offset)
      .limit(limit)
      .findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favoriteMovie = await isar.movies
      .filter()
      .idEqualTo(movie.id)
      .findFirst();

    if (favoriteMovie != null) {
      // Remove movie from favorites movie
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.isarId!));
      return;
    }

    // Insert movie to favorites movies
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }

}
