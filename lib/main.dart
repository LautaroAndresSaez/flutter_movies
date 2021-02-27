import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/home.dart';
import 'package:peliculas/src/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peliculas',
      initialRoute: Home.route,
      debugShowCheckedModeBanner: false,
      routes: getRoutes(),
    );
  }
}
