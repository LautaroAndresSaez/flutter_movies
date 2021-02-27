import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_response.dart';
import 'package:peliculas/src/pages/movie_detail.dart';
import 'package:peliculas/src/providers/movies_provider.dart';

class MoviesSearch extends SearchDelegate {
  final MoviesProvider _moviesProvider = MoviesProvider();

  String selected = '';
  final movies = ['hola', 'spiderman', 'Shazam', 'pedrito vm'];
  final recientes = ['caca', 'pis'];

  @override
  List<Widget> buildActions(BuildContext context) {
    //Accionas de nuestro appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Icono a la izquierda del appbar

    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    //Crea los resultados
    return Center(
      child: Container(
        height: 100,
        width: 100,
        color: Colors.redAccent,
        child: Text(selected),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: _moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = movies[index];
              movie.uniqueId = '${movie.id}-search';
              return ListTile(
                leading: Hero(
                  tag: movie.uniqueId,
                  child: FadeInImage(
                    image: NetworkImage(movie.getPoster()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                    height: 50,
                  ),
                ),
                title: Text(movie.title),
                onTap: () {
                  close(context, null);
                  Navigator.pushNamed(context, MovieDetail.route,
                      arguments: movie);
                },
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
