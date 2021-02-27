import 'package:flutter/widgets.dart';
import 'package:peliculas/src/pages/home.dart';
import 'package:peliculas/src/pages/movie_detail.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    Home.route: (BuildContext context) => Home(),
    MovieDetail.route: (BuildContext context) => MovieDetail(),
  };
}
