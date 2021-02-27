import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_response.dart';
import 'package:peliculas/src/pages/movie_detail.dart';
import 'package:peliculas/src/widgets/movie_card.dart';

class InfinityScrollHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final _pageController = PageController(initialPage: 1, viewportFraction: .3);
  final loadMovies;

  InfinityScrollHorizontal({@required this.movies, this.loadMovies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 100) {
        loadMovies();
      }
    });

    return Container(
        height: _screenSize.height * .3,
        child: PageView.builder(
          controller: _pageController,
          pageSnapping: false,
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            final movie = movies[index];
            movie.uniqueId = '${movie.id}-slider';
            return GestureDetector(
              child: Hero(
                tag: movie.uniqueId,
                child: MovieCard(movie: movie),
              ),
              onTap: () {
                Navigator.pushNamed(context, MovieDetail.route,
                    arguments: movie);
              },
            );
          },
        ));
  }
}
