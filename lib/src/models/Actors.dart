import 'package:peliculas/src/models/actor.dart';

class Actors {
  List<Actor> actors = [];

  Actors.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    }
    actors = jsonList.map((json) => Actor.fromJson(json)).toList();
  }
}
