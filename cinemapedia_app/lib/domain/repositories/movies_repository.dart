import 'package:cinemapedia_app/domain/entities/movie.dart';

abstract class MoviesRepository { // abstract means you do not want to create instances of this class

  Future <List<Movie>> getNowPlaying({int page = 1});

  Future <List<Movie>> getPopulars({int page = 1});

  Future <List<Movie>> getTopRated({int page = 1});

  Future <List<Movie>> getUpcoming({int page = 1});

}
