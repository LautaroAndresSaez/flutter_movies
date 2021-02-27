import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_response.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  MovieCard({this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: FadeInImage(
            image: NetworkImage(movie.getPoster()),
            placeholder: AssetImage('assets/img/no-image.jpg'),
            fit: BoxFit.cover,
            height: 150,
          ),
        ),
        SizedBox(height: 5),
        Text(
          movie.title,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }
}
