import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia_app/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia_app/infrastructure/repositories/movie_repository_impl.dart';

// is unmutable, only lecture
final movieRepositoryProvider = Provider((ref) {

  return MovieRepositoryImpl(MoviedbDatasource());

  // return MovieRepositoryImpl(IMDBDatasource()); // in case another datasource
});
