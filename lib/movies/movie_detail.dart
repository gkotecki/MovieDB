import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';

import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:myapp/movies/movie.dart';
import 'package:myapp/movies/movie_favorites.dart';
import 'package:myapp/util/alerta.dart';
import 'package:myapp/util/db_tools.dart';

class MovieDetail extends StatefulWidget {
  final Movie movie;
  MovieDetail(this.movie);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  var image_url = 'https://image.tmdb.org/t/p/w500/';

  void initState() {
    super.initState();
    checkFavoritado(widget.movie).then((value) {
      setState(() {
        widget.movie.favoritado = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 40, 40),
      body: Stack(
        fit: StackFit.expand,
        children: [
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              //    FOTO PRINCIPAL

              SliverAppBar(
                centerTitle: true,
                title: Text(
                  widget.movie.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(0, 0),
                        blurRadius: 5,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.black,
                pinned: true,
                floating: false,
                snap: false,
                expandedHeight: 700,
                elevation: 5,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    image_url + widget.movie.posterPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      margin: const EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          //    TITULO

                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 0,
                            ),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    widget.movie.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),

                                //    AVALIACAO
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Avaliação',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      '${widget.movie.voteAverage}/10',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          //    DESCRICAO
                          Text(
                            "\nTítulo original: " +
                                widget.movie.originalTitle +
                                "\nLançamento: " +
                                widget.movie.releaseDate +
                                "\n",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            widget.movie.overview,
                            style: TextStyle(color: Colors.white),
                          ),

                          //    BOTOES
                          Padding(padding: const EdgeInsets.all(10)),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  color: Colors.red,
                                  elevation: 5,
                                  onPressed: () => adicionarAosFavoritos(
                                      widget.movie, context),
                                  child: Padding(
                                    padding: const EdgeInsets.all(11),
                                    child: Text(
                                      // 'Meus Favoritos',
                                      widget.movie.favoritado
                                          ? 'Remover dos favoritos'
                                          : 'Favoritar!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

Future<bool> checkFavoritado(Movie movieToAdd) async {
  List<Movie> lista = await movies();

  if (lista.any((Movie m) => m.id == movieToAdd.id) == true) {
    movieToAdd.favoritado = true;
    return true;
  } else {
    movieToAdd.favoritado = false;
    return false;
  }
}

Future<bool> adicionarAosFavoritos(Movie movieToAdd, context) async {
  // print('> adicionando o filme ' + movieToAdd.title);

  List<Movie> lista = await movies();

  if (lista.any((Movie m) => m.id == movieToAdd.id) == true) {
    deleteMovie(movieToAdd.id);
    enviaAlerta(context, 'Removido dos favoritos!', 'OK');
    return false;
  } else {
    insertMovie(movieToAdd);
    print(await movies());
    enviaAlerta(context, 'Adicionado aos favoritos!', 'OK');
    return true;
  }
}
