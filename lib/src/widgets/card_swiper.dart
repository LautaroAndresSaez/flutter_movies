import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/movie_response.dart';
import 'package:peliculas/src/pages/movie_detail.dart';
import 'package:peliculas/src/widgets/loading_image.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  final bool isStacked;

  CardSwiper(this.movies, [this.isStacked = true]);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          final movie = movies[index];
          movie.uniqueId = '${movie.id}-cards';
          final posterUrl = movie.getPoster();
          return GestureDetector(
            child: Hero(
                tag: movie.uniqueId,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LoadingImage(posterUrl))),
            onTap: () {
              Navigator.pushNamed(context, MovieDetail.route, arguments: movie);
            },
          );
        },
        itemHeight: _screenSize.height * .5,
        itemWidth: _screenSize.width * .7,
        itemCount: movies.length,
        layout: isStacked ? SwiperLayout.STACK : SwiperLayout.DEFAULT,
      ),
    );
  }
}
