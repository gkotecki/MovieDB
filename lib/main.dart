import 'package:flutter/material.dart';
import 'package:myapp/login/login_page.dart';
import 'movies/movie_list.dart';
import 'teste.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(primaryColor: Colors.red),
      home: new MovieList(),
    );
  }
}
