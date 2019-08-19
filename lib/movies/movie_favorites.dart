import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/util/TmdbApi.dart';
import 'package:myapp/util/blue_button.dart';
import 'package:myapp/util/db_tools.dart';

import 'movie.dart';
import 'movie_cell.dart';
import 'movie_list.dart';
import 'movie_detail.dart';

import 'dart:io';

bool estaLogado = true;

class MovieFavorites extends StatefulWidget {
  @override
  _MovieFavoritesState createState() => _MovieFavoritesState();
}

class _MovieFavoritesState extends State<MovieFavorites> {
  List<Movie> listFavs;
  var image_url = 'https://image.tmdb.org/t/p/w500/';

  void getFavoritos() async {
    var lista = await movies();
    if (this.mounted) {
      setState(() {
        listFavs = lista;
        listFavs.sort((a, b) => b.popularity.compareTo(a.popularity));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (estaLogado) {
      // IMPLEMENTAR ESQUEMA DE LOGIN
      return _listaFavoritos();
    } else {
      return _paginaLogin();
    }
  }

  _paginaLogin() {
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 40, 32, 40),
            child: Text(
              "Para favoritar filmes, faça login com sua conta Google pressionando o botão abaixo:",
              textAlign: TextAlign.center,
              textScaleFactor: 1.2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: BlueButton(
              estaLogado.toString(),
              () => loginComOGoogle(),
            ),
          ),
        ],
      ),
    );
  }

  _listaFavoritos() {
    getFavoritos();
    return Container(
      child: listFavs == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : listFavs.length == 0
              ? Center(
                  child: Text(
                      "Você ainda não tem nenhum favorito!\nSelecione um filme e pressione o botão 'Favoritar!'"),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: listFavs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                      child: Material(
                        elevation: 10,
                        type: MaterialType.card,
                        child: Container(
                          decoration: listFavs[index].backdropPath == null
                              ? null
                              : BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(image_url +
                                        listFavs[index].backdropPath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          child: FlatButton(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(8, 80, 8, 40),
                              child: Text(
                                listFavs[index].title,
                                textScaleFactor: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(0, 5),
                                      blurRadius: 20,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    Shadow(
                                      offset: Offset(0, -5),
                                      blurRadius: 20,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    Shadow(
                                      offset: Offset(0, 0),
                                      blurRadius: 10,
                                      color: Color.fromARGB(100, 255, 0, 0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return MovieDetail(listFavs[index]);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  _trocaEstaLogado() {
    setState(() {
      estaLogado = !estaLogado;
    });
  }

  loginComOGoogle() {
    _trocaEstaLogado();
  }

  // void pegaFavoritosDoBanco() async {
  //   listaFavoritos = await movies();
  // }
}
