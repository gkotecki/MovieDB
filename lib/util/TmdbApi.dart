import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// minha key
var apiKey = '1a39052fdeecaa40640b06845e4b108d';

Future<Map> getJsonMovieList() async {
  var url = 'http://api.themoviedb.org/3/discover/movie?api_key=' +
      apiKey +
      '&language=pt-BR';

  http.Response response = await http.get(url);
  return json.decode(response.body);
}

Future<Map> getJsonMovieById(String id) async {
  var url = 'http://api.themoviedb.org/3/movie/' +
      id +
      '?api_key=' +
      apiKey +
      '&language=pt-BR';

  http.Response response = await http.get(url);
  return json.decode(response.body);
}

//-------------------------------------------------------------------
//-- Funções de fetch URL da API do TMBD ----------------------------
//-------------------------------------------------------------------

String getUrlPopularMovies() {
  var url = 'http://api.themoviedb.org/3/discover/movie?api_key=' +
      apiKey +
      '&language=pt-BR';
  return url;
}

String getUrlSearchMovies(String query) {
  var url = 'https://api.themoviedb.org/3/search/movie?query=' +
      query +
      '&api_key=' +
      apiKey +
      '&language=pt-BR';
  return url;
}
