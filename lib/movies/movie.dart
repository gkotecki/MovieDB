import 'dart:convert';
import 'package:http/http.dart' as http;

class Movie {
  int voteCount;
  int id;
  String voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  String backdropPath;
  String overview;
  String releaseDate;
  bool favoritado;

  Movie(
      {this.voteCount,
      this.id,
      this.voteAverage,
      this.title,
      this.popularity,
      this.posterPath,
      this.originalLanguage,
      this.originalTitle,
      this.backdropPath,
      this.overview,
      this.releaseDate});

  Movie.fromJson(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    voteAverage = json['vote_average'].toString();
    title = json['title'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    backdropPath = json['backdrop_path'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vote_count'] = this.voteCount;
    data['id'] = this.id;
    data['vote_average'] = this.voteAverage;
    data['title'] = this.title;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['backdrop_path'] = this.backdropPath;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, releaseDate: $releaseDate}';
  }
}

Future<List<Movie>> fetchMovies(String apiUrl) async {
  MovieList movieList;
  var res = await http.get(apiUrl);
  var decodeRes = jsonDecode(res.body);
  movieList = MovieList.fromJson(decodeRes);
  return movieList.movies;
}

class MovieList {
  int page;
  int totalMovies;
  int totalPages;
  List<Movie> movies;

  MovieList({this.page, this.totalMovies, this.totalPages, this.movies});

  MovieList.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalMovies = json['total_results'];
    totalPages = json['total_pages'];
    if (json['results'] != null) {
      movies = new List<Movie>();
      json['results'].forEach((v) {
        movies.add(new Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['total_results'] = this.totalMovies;
    data['total_pages'] = this.totalPages;
    if (this.movies != null) {
      data['results'] = this.movies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
