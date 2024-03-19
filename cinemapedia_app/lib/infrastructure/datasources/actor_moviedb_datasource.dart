
import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasource extends ActorsDatasource {

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environemnt.theMovieDBApiKey,
        'language': 'en-USA'
      }
    )
  );

  List<Actor> _jsonToActors(Map<String, dynamic> jsonData) {

    // Call the model where we have the method fromJson
    final actorResponse = CreditsResponse.fromJson(jsonData);

    final List<Actor> actors = actorResponse.cast
    .map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();

    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    return _jsonToActors(response.data);
  }

}