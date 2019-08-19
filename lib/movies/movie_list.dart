import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myapp/login/login_page.dart';
import 'package:myapp/movies/movie_favorites.dart';
import 'package:myapp/movies/search/movie_search.dart';
import 'package:myapp/movies/search/search_view.dart';
import 'package:myapp/util/TmdbApi.dart';
import 'package:myapp/util/blue_button.dart';
import 'package:myapp/util/db_tools.dart';
import 'package:myapp/util/nav.dart';
import 'movie.dart';
import 'movie_cell.dart';
import 'movie_detail.dart';

var bancoAberto = false;

class MovieList extends StatefulWidget {
  @override
  MovieListState createState() => new MovieListState();
}

class MovieListState extends State<MovieList> {
  var movies;

  // jeito novo d fetch filmes
  void initState() {
    super.initState();
    fetchMovies(getUrlPopularMovies()).then((value) {
      print(value.length);
      setState(() {
        movies = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (bancoAberto == false) abreBancoDeDados();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255,230,230,230),
        appBar: AppBar(
          centerTitle: true,
          title: Text('MovieDB'),
          elevation: 6,
          // implementando search
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final Movie result =
                    await showSearch(context: context, delegate: MovieSearch());
                if (result != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetail(result),
                    ),
                  );
                }
              },
            )
          ],
          //fim search
          bottom: TabBar(
            tabs: [Tab(text: "Populares"), Tab(text: "Favoritos")],
          ),
        ),
        body: TabBarView(
          children: [
            builderMovieCell(),
            MovieFavorites(),
          ],
        ),
      ),
    );
  }

  Container builderMovieCell() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: movies == null ? 0 : movies.length,
              itemBuilder: (context, i) {
                return 
                MovieCell(movies, i);
              },
            ),
          )
        ],
      ),
    );
  }
}
