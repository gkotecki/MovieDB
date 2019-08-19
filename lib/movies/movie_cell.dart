import 'package:flutter/material.dart';
import 'package:myapp/movies/movie.dart';

import 'movie_detail.dart';

class MovieCell extends StatelessWidget {
  final List<Movie> movies;
  final id;
  var image_url = 'https://image.tmdb.org/t/p/w500/';
  MovieCell(this.movies, this.id);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8,8,8,0),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 3,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MovieDetail(movies[id]);
                },
              ),
            );
          },
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(8),
                child: _containerMoviePoster(),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 0, 6, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movies[id].title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(padding: const EdgeInsets.all(6)),
                      Text(
                        movies[id].overview,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _containerMoviePoster() {
    return Container(
      width: 90,
      height: 120,
      child: Material(
        child: Image(
          image: NetworkImage(image_url + movies[id].posterPath),
          fit: BoxFit.cover,
        ),
        elevation: 3,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}
