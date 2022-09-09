import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:peli_app/models/models.dart';
import 'package:peli_app/models/search_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'b8ce44dd2d1edf048776cc9cdeec42e7';
  String _baseURL = 'api.themoviedb.org';
  String _lenguage = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> onDisplayPopularMovies = [];
  int _popularPage = 0;

  Map<int, List<Cast>> moviesCast = {};

  MoviesProvider() {
    getOnDisplayMovies();
    getOnDisplayPopularMovies();
  }
  //'3/movie/now_playing'

  Future<String> _propertisUrl(String complain, [int page = 1]) async {
    var url = Uri.http(_baseURL, complain, {
      'api_key': _apiKey,
      'language': _lenguage,
      'page': '$page',
    });
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    var reponse = await _propertisUrl('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(reponse);
    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getOnDisplayPopularMovies() async {
    _popularPage++;

    var response = await _propertisUrl('3/movie/popular', _popularPage);
    final nowPopularResponse = PopularResponse.fromJson(response);
    onDisplayPopularMovies = [
      ...onDisplayPopularMovies,
      ...nowPopularResponse.results
    ];

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int id) async {
    //TODO: revisar el mapa

    if (moviesCast.containsKey(id)) {
      return moviesCast[id]!;
    }

    final response = await _propertisUrl('3/movie/$id/credits');
    final creditsResponse = CreditsResponse.fromJson(response);

    moviesCast[id] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> serachMovie(String query) async {
    final url = Uri.http(_baseURL, '3/search/movie', {
      'api_key': _apiKey,
      'language': _lenguage,
      'page': '1',
      'query': query,
      'include_adult': 'false'
    });
    final response = await http.get(url);

    final movieSearch = SearchResponse.fromJson(response.body);

    return movieSearch.results;
  }
}
