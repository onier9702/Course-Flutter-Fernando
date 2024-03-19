import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/presentation/providers/actors/actors_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier,Map<String,List<Actor>>>((ref) {

  final actorsByMovieRepository = ref.watch(actorsRepositoryProvider); // only the reference

  return ActorsByMovieNotifier(
    getActorsByMovieMethod: actorsByMovieRepository.getActorsByMovie
  );

});


/* 
  {
    '505642': <Actor>[],
    '505643': <Actor>[],
    '505644': <Actor>[],
  }

*/

typedef GetActorsCallback = Future<List<Actor>>Function(String movieId); // just the definition

class ActorsByMovieNotifier extends StateNotifier<Map<String,List<Actor>>> {

  final GetActorsCallback getActorsByMovieMethod;

  // Constructor
  ActorsByMovieNotifier({
    required this.getActorsByMovieMethod
  }): super({});

  Future<void> loadActors(String movieId) async {

    if (state[movieId] != null) return; // have this List<Actor> on cache
    // print('New http call.');
    final actors = await getActorsByMovieMethod(movieId);
    state = {...state, movieId: actors};

  }

}
