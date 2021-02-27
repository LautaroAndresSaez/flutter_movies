import 'package:flutter/material.dart';

import 'package:peliculas/src/models/actor.dart';

class ActorsPageView extends StatelessWidget {
  final List<Actor> cast;

  ActorsPageView({this.cast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        pageSnapping: false,
        itemBuilder: (BuildContext context, int i) => _actorCard(cast[i]),
        itemCount: cast.length,
        controller: PageController(viewportFraction: .3, initialPage: 1),
      ),
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                image: NetworkImage(actor.getPhoto()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                height: 150,
                fit: BoxFit.cover,
              )),
          SizedBox(
            height: 3,
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
