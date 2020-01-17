import 'package:movies/src/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class MoviesProvider{

  String _apikey = '05efc4f75dc34d53117289846539a265';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

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
    
    final url = Uri.https(_url, '3/movie/popular',{
      'api_key' : _apikey,
      'language' : _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = new Movies.fromJsonList(decodedData['results']);
    return movies.items;
  }

}