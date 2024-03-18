
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environemnt {

  static String theMovieDBApiKey = dotenv.env['MOVIE_DB_API_KEY'] ?? 'There is not api key' ;

}
