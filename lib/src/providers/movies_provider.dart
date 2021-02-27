import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/Actors.dart';
import 'package:peliculas/src/models/actor.dart';

import 'package:peliculas/src/models/movie_response.dart';
import 'package:peliculas/src/models/movies.dart';

class MoviesProvider {
  final String _apiKey = 'd84eb6f651ba118b19bb607964c38aab';
  final String _url = 'api.themoviedb.org';
  final String _language = 'es-ES';
  int _popularPage = 0;
  bool isLoading = false;

  List<Movie> _populars = List();

  final _popularsStream = StreamController<List<Movie>>.broadcast();

  void dispose() {
    _popularsStream?.close();
  }

  Function(List<Movie>) get popularsSink => _popularsStream.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStream.stream;

  Future<List<Movie>> _getMovies(Uri url) async {
    final response = await http.get(url);
    final results = json.decode(response.body)['results'];
    return Movies.fromJsonList(results).movies;
  }

  Future<List<Movie>> getInTheaters() {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return _getMovies(url);
  }

  Future<List<Movie>> getPopulars() async {
    _popularPage++;
    if (isLoading) {
      return [];
    }
    isLoading = true;
    final url = Uri.https(_url, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': '$_popularPage'});

    final movies = await _getMovies(url);
    _populars.addAll(movies);
    popularsSink(_populars);
    isLoading = false;
    return movies;
  }

  Future<List<Actor>> getCast(String id) async {
    final url = Uri.http(_url, '3/movie/$id/credits',
        {'api_key': _apiKey, 'language': _language});

    final response = await http.get(url);
    final results = json.decode(response.body)['cast'];
    return Actors.fromJsonList(results).actors;
  }

  Future<List<Movie>> searchMovie(String query) {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    return _getMovies(url);
  }
}
