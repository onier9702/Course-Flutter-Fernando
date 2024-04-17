import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';

class MovieDetailScreen extends ConsumerStatefulWidget {

  static const name = 'movie_detail';

  final String movieId;

  const MovieDetailScreen({
    super.key,
    required this.movieId
  });

  @override
  MovieDetailScreenState createState() => MovieDetailScreenState();
}

class MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {

  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(), // avoid jump when screen open
        slivers: [
          _CustomSliverAppbar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDescription(movie: movie),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieDescription extends StatelessWidget {

  final Movie movie;

  const _MovieDescription({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),

              // Space
              const SizedBox(width: 10),

              // Description
              SizedBox(
                width: (size.width - 40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyles.titleLarge),
                    Text(movie.overview)
                  ],
                ),
              ),
            ],
          ),
        ),

        // Genres
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((genre) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(genre),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ))
            ],
          ),
        ),

        // Listview of actors
        _ActorsByMovie(movieId: movie.id.toString()),

        // to let user see all content and make scroll at the bottom
        const SizedBox(height: 50),

      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {

  final String movieId;

  const _ActorsByMovie({
    required this.movieId
  });

  @override
  Widget build(BuildContext context, ref) {

    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }

    final actors = actorsByMovie[movieId]!; // always have the actors

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Actor photo
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    actor.profilePath,
                    height: 180,
                    width: 135,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 5),

                // Actor name
                Text(actor.name, maxLines: 2),
                Text(
                  actor.character ?? '',
                  maxLines: 1,
                  style: const TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis)
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}

// Here we create a future provider to get if movie is fav or not
final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return localStorageRepository.isMovieFavorite(movieId); // if the movie is on favorites
});

class _CustomSliverAppbar extends ConsumerWidget {

  final Movie movie;

  const _CustomSliverAppbar({
    required this.movie
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Here we have the reference to the future provider 
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      // Actions to set over this sliver app bar
      actions: [
        IconButton(
          onPressed: () async {
            // Toggle one favorite movie or not
            // ref.read(localStorageRepositoryProvider)
            //   .toggleFavorite(movie);

            // Here we changed the use of other provider
            await ref.read(favoriteMoviesProvider.notifier)
              .toggleFavoriteMovie(movie);

            // Invalidate isFavoriteProvider method to reload state
            // In other words, this reload the provider
            ref.invalidate(isFavoriteProvider(movie.id));
          },
          icon: isFavoriteFuture
            .when(
              loading: () => const Icon(Icons.favorite_border), // display empty heart when loading
              data: (isFavorite) => isFavorite
                ? const Icon(Icons.favorite_rounded, color: Colors.red)
                :const Icon(Icons.favorite_border),
              error: (_, __) => throw UnimplementedError(),
            ),
          // icon: const Icon(Icons.favorite_border)
          // icon: const Icon(Icons.favorite_border, color: Colors.red)
        )
      ],
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.start,
        ),
        background: Stack(
          children: [

            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();

                  return FadeIn(child: child);
                },
              ),
            ),

            const _CustomGradient( // to be able to see the title
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.8, 1.0],
              colors: [Colors.transparent, Colors.black54],
            ),

            const _CustomGradient( // to be able to see the favorite heart icon
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [Colors.black54, Colors.transparent],
            ),

            const _CustomGradient( // to be able to see the back route arrow
              begin: Alignment.topLeft,
              end: Alignment.center,
              stops: [0.0, 0.23],
              colors: [Colors.black87, Colors.transparent],
            ),

          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {

  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    required this.begin,
    required this.stops,
    required this.colors,
    required this.end
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox( // to be able to see the favorite heart icon
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors
          ),
        ),
      ),
    );
  }
}
