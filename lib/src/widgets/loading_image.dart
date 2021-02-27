import 'package:flutter/material.dart';

class LoadingImage extends StatelessWidget {
  final String _url;
  LoadingImage(this._url);

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      image: NetworkImage(_url),
      placeholder: AssetImage('assets/img/no-image.jpg'),
      fit: BoxFit.cover,
    );
  }
}
