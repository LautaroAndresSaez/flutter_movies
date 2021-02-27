import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper.dart';
import 'package:peliculas/src/widgets/infinity_scroll_horizontal.dart';

class Home extends StatelessWidget {
  static String route = '';
  final _movieProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    _movieProvider.getPopulars();
    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas en cine'),
          backgroundColor: Colors.purple,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: MoviesSearch());
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_createSwiper(), _footer(context)],
          ),
        ));
  }

  _createSwiper() {
    return FutureBuilder(
      future: _movieProvider.getInTheaters(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(snapshot.data);
        }
        return Container(
            height: 400,
            child: Center(
              child: CircularProgressIndicator(),
            ));
      },
    );
  }

  _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 15),
              child: Text('Populares',
                  style: Theme.of(context).textTheme.subtitle1)),
          SizedBox(
            height: 5,
          ),
          StreamBuilder(
            stream: _movieProvider.popularsStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return InfinityScrollHorizontal(
                  movies: snapshot.data,
                  loadMovies: _movieProvider.getPopulars,
                );
              }
              return Image(
                image: AssetImage('assets/img/loading.gif'),
                height: 150,
              );
            },
          ),
        ],
      ),
    );
  }
}
