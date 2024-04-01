import 'package:flutter/material.dart';
import 'dart:async';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/config/helpers/human_format.dart';


typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovies;

  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  StreamController<bool> isLoadingMovies = StreamController.broadcast();

  Timer? _debounceTimer; // it is the timeOut function of JavaScript

  List<Movie> initialMovies;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies,
  });

  void clearStreams() {
    debounceMovies.close(); // The same in Angular closing a subscription
  }

  void _onQueryChanged(String query) {

    isLoadingMovies.add(true);
    
    // This will be printed for each letter in keyboard typed
    // print('Query string changed');

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      // This code will be invoked after 500 miliseconds
      // print('Searching suggestion movies');

      // if (query.isEmpty) { // This is not necessary cause was made in datasource
      //   debounceMovies.add([]);
      //   return;
      // }

      // Search movies and emit to the stream builder
      final movies = await searchMovies(query); // call the searchMovies callback
      debounceMovies.add(movies);
      isLoadingMovies.add(false);
      initialMovies = movies; // to save the last movies and display after enter keyup 
    });
  }

  @override
  String get searchFieldLabel => 'Search movie';


  // To avoid repeat code at buildResults and buildSuggestions
  Widget buildResultsAndSuggesions() {

    return StreamBuilder(
      initialData: initialMovies,
      stream: debounceMovies.stream,   
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _MovieItem(
              movie: movies[index],
              onMovieSelected: (context, movie) {
                clearStreams(); // clean or clear streams
                close(context, movie);
              }, // global close function that delegate bring bu default
            );
          },
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) { // action to make at search
    return [

      StreamBuilder(
        initialData: false,
        stream: isLoadingMovies.stream,
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              infinite: true,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.refresh_outlined) // clear the input search
              ),
            );
          }

          return FadeIn(
            animate: query.isNotEmpty, // fernando package animate
            child: IconButton(
              onPressed: () => query = '', // this query is a reserved word inside search delegate class
              icon: const Icon(Icons.clear) // clear the input search
            ),
          );
        },
      )
    ];
  }

  // When search delegate is closed by arrow back
  @override
  Widget? buildLeading(BuildContext context) { // To come back
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildResultsAndSuggesions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    // this will be triggered each time query change by one letter
    _onQueryChanged(query);

    return buildResultsAndSuggesions();
  }

}

class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie,
    required this.onMovieSelected,
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        // this close the search app bar after click over one movie
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // IMage
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  // loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                ),
              ),
            ),
      
            const SizedBox(width: 10),
      
            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
      
                  (movie.overview.length > 100)
                   ? Text('${movie.overview.substring(0,100)}...', style: textStyles.titleSmall)
                   : Text(movie.overview, style: textStyles.titleSmall),
      
                  Row(children: [
                    Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
                    const SizedBox(width: 5),
                    Text(
                      HumanFormat.number(movie.voteAverage, 1),
                      style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900)
                    )
                  ],)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
