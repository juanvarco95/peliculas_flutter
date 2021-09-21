import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Api: 588d0d91aa5aa8d10b77025c2fa62266
class MoviesProvider extends ChangeNotifier {
  String _apiKey = '588d0d91aa5aa8d10b77025c2fa62266';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  MoviesProvider() {
    print('MoviesProvider Inicializado');

    this.getOnDiplayMovies();
  }

  getOnDiplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });
    final response = await http.get(url);

    print(response.body);
  }
}
