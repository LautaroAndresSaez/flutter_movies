import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actor.dart';
import 'package:peliculas/src/models/movie_response.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:peliculas/src/widgets/acotrs_page_view.dart';

class MovieDetail extends StatelessWidget {
  static String route = 'detail-movie';
  final MoviesProvider _moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _createAppBar(movie),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 10,
            ),
            _titlePoster(context, movie),
            _description(movie),
            _description(movie),
            _description(movie),
            _description(movie),
            _description(movie),
            _description(movie),
            _description(movie),
            _description(movie),
            _cast(movie.id),
          ]),
        ),
      ],
    ));
  }

  _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2,
      backgroundColor: Colors.purpleAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(fontSize: 16),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBanner()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 300),
        ),
      ),
    );
  }

  _titlePoster(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
              tag: movie.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: NetworkImage(movie.getPoster()),
                  height: 150,
                ),
              )),
          SizedBox(
            width: 20,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title,
                    style: Theme.of(context).textTheme.headline6,
                    overflow: TextOverflow.ellipsis),
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subtitle1)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _description(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  _cast(int id) {
    return FutureBuilder(
      future: _moviesProvider.getCast('$id'),
      builder: (BuildContext context, AsyncSnapshot<List<Actor>> snapshot) {
        if (snapshot.hasData) {
          return ActorsPageView(cast: snapshot.data);
        }
        return CircularProgressIndicator();
      },
    );
  }
}
