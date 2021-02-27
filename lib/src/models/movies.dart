import 'package:peliculas/src/models/movie_response.dart';

class Movies {
  List<Movie> movies = List();

  Movies();

  Movies.fromJsonList(List<dynamic> response) {
    if (response == null) {
      return;
    }
    movies = response.map((jsonMovie) => Movie.fromJsonMap(jsonMovie)).toList();
  }
}
