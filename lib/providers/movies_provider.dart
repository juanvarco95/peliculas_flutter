import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

// Api: 588d0d91aa5aa8d10b77025c2fa62266
class MoviesProvider extends ChangeNotifier {
  // Para hacer uso de la api: https://developers.themoviedb.org/3/movies/get-now-playing
  String _apiKey = '588d0d91aa5aa8d10b77025c2fa62266';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];

  // Constructor
  MoviesProvider() {
    print('MoviesProvider Inicializado');

    this.getOnDiplayMovies();
  }
  // Future: Se usa para esperar la respuesta del servidor
  getOnDiplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });
    // Respuesta, el await se usa para esperar la respuesta del http
    final response = await http.get(url);
    // Se llama los modelos para tener más claridad de lo que se obtiene del Json
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    // print(nowPlayingResponse.results[1].title);
    onDisplayMovies = nowPlayingResponse.results;

    // Para que todos los Listeners de los controladores usados se den cuenta de los cambios
    notifyListeners();
  }
}
