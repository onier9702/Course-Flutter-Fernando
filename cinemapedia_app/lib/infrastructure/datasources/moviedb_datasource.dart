
import 'package:cinemapedia_app/infrastructure/models/moviedb/movie_details.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/moviedb/moviedb_response.dart';

class MoviedbDatasource extends MoviesDataSource {

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environemnt.theMovieDBApiKey,
        'language': 'en-USA'
      }
    )
  );

  List<Movie> _jsonToMovies(Map<String, dynamic> jsonData) {
    final movieDbResponse = MoviedbResponse.fromJson(jsonData);

    final List<Movie> movies = movieDbResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing',
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getPopulars({int page = 1}) async {
    final response = await dio.get('/movie/popular',
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated',
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming',
      queryParameters: {
        'page': page
      }
    );

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<Movie> getMovieById(String id) async {
    
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) throw Exception('Movie with ID: $id not found.');

    // Transform the data api from Json to adapt the name of properties to my own properties
    final moviedetails = MovieDetails.fromJson(response.data);

    // Transform the MovieDetails(json of my own properties) to the general Movie object we use on the app
    final Movie movie = MovieMapper.movieDetailsToEntity(moviedetails);

    return movie;

  }



}
