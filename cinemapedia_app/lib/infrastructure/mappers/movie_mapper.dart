import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMoviedb movieMovieDB) => Movie(
      adult: movieMovieDB.adult,
      backdropPath: (movieMovieDB.backdropPath != '')
        ? 'https://image.tmdb.org/t/p/w500/${movieMovieDB.backdropPath}'
        : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtTO_uIyY3HEiBRqnIFjQsEsSaSUdVQjejGt0zaXdYiw&s',
      genreIds: movieMovieDB.genreIds.map((e) => e.toString()).toList(),
      id: movieMovieDB.id,
      originalLanguage: movieMovieDB.originalLanguage,
      originalTitle: movieMovieDB.originalTitle,
      overview: movieMovieDB.overview,
      popularity: movieMovieDB.popularity,
      posterPath: (movieMovieDB.posterPath != '')
       ? 'https://image.tmdb.org/t/p/w500/${movieMovieDB.posterPath}'
       : 'no-poster',
      // releaseDate: movieMovieDB.releaseDate,
      title: movieMovieDB.title,
      video: movieMovieDB.video,
      voteAverage: movieMovieDB.voteAverage,
      voteCount: movieMovieDB.voteCount);
}
