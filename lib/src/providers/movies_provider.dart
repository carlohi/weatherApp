import 'dart:async';

import 'package:movies/src/models/ActorsModel.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class MoviesProvider{

  String _apikey = '05efc4f75dc34d53117289846539a265';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  int _popularesPage = 0;
  bool _loading = false;
  List<Movie> _populars = new List();
  final _popularStreamController = StreamController<List<Movie>>.broadcast();
  
  Function (List<Movie>) get popularSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  void disposeStreams(){
    _popularStreamController?.close();
  }

  Future<List<Movie>> _processResponse(Uri url) async{
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = new Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async{
    
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apikey,
      'language' : _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = new Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Movie>> getPopular() async{
    
    if( _loading ) return [];

    _loading = true;

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular',{
      'api_key' : _apikey,
      'language' : _language,
      'page' : _popularesPage.toString()
    });

    final resp = await _processResponse(url);
    _populars.addAll(resp);
    popularSink(_populars) ;
    _loading = false;
    return resp;
  }

  Future<List<Actor>> getCast(String movieId) async{
    final url = Uri.https(_url, '3/movie/${movieId}/credits',{
      'api_key': _apikey,
      'language':_language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actors;
  }

  Future<List<Movie>> getSearchList(String query) async{
    final url = Uri.https(_url, '3/search/movie',{
      'api_key': _apikey,
      'language':_language,
      'query' : query
    });

    return await _processResponse(url);
  }

}