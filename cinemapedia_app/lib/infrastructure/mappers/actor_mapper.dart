
import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {

  static Actor castToEntity(Cast cast) => Actor(
    id: cast.id,
    name: cast.name,
    profilePath: cast.profilePath == null 
      ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtTO_uIyY3HEiBRqnIFjQsEsSaSUdVQjejGt0zaXdYiw&s'
      : 'https://image.tmdb.org/t/p/w500/${cast.profilePath}',
    character: cast.character
  );

}
