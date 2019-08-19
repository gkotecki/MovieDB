import 'package:flutter/material.dart';
import 'package:myapp/movies/movie.dart';
import 'package:myapp/util/TmdbApi.dart';

class SearchMovieWidget extends StatefulWidget {
  final String query;
  final Function(Movie) onTap;
  SearchMovieWidget({this.query, this.onTap});
  @override
  _SearchMovieWidgetState createState() => _SearchMovieWidgetState();
}

class _SearchMovieWidgetState extends State<SearchMovieWidget> {
  List<Movie> moviesList;

  var image_url = 'https://image.tmdb.org/t/p/w300/';
  @override
  void initState() {
    super.initState();
    fetchMovies(getUrlSearchMovies(widget.query)).then((value) {
      print(value.length);
      setState(() {
        moviesList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: moviesList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : moviesList.length == 0
              ? Center(
                  child: Text(
                    "Nenhum filme encontrado!",
                  ),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: moviesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => widget.onTap(moviesList[index]),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: moviesList[index].posterPath == null
                                        ? Text(
                                            'imagem não encontrada',
                                            textAlign: TextAlign.center,
                                            textScaleFactor: .8,
                                          )
                                        : Image(
                                            image: NetworkImage(image_url +
                                                moviesList[index].posterPath),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 0, 8),
                                          child: Text(
                                            moviesList[index].title,
                                            overflow: TextOverflow.ellipsis,
                                            textScaleFactor: 1.1,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Text('Lançamento: ' +
                                                moviesList[index].releaseDate),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
