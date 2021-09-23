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
  List<Movie> onDisplayPopularMovies = [];

  Map<int, List<Cast>> movieCast = {};

  int _popularInt = 0;

  // Constructor
  MoviesProvider() {
    print('MoviesProvider Inicializado');

    this.getOnDisplayMovies();
    this.getOnDisplayPopularMovies();
    notifyListeners();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });
    // Genera un error sin el try and catch
    try {
      print('Entrando al try...');
      final response = await http.get(url);
      return response.body;
    } on Exception catch (_) {
      throw Exception("Error en el server...");
    }
    // final response = await http.get(url);
    // return response.body;
  }

  // Future: Se usa para esperar la respuesta del servidor
  getOnDisplayMovies() async {
    // Respuesta, el await se usa para esperar la respuesta del http
    final jsonData = await _getJsonData('3/movie/now_playing');
    // Se llama los modelos para tener más claridad de lo que se obtiene del Json
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    // print(nowPlayingResponse.results[1].title);
    onDisplayMovies = nowPlayingResponse.results;
    // Para que todos los Listeners de los controladores usados se den cuenta de los cambios
    notifyListeners();
  }

  getOnDisplayPopularMovies() async {
    _popularInt++;
    final jsonData = await _getJsonData('3/movie/popular', _popularInt);

    final popularPlayingResponse = Popular.fromJson(jsonData);
    // Para hacer el infinite scroll
    onDisplayPopularMovies = [
      ...onDisplayMovies,
      ...popularPlayingResponse.results
    ];
    notifyListeners();
  }

  Future<List<Cast>> getCastMovies(int movieId) async {
    // Para que se mantenga en memoria
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;

    print('Pidiendo la info al servidor - Cast');
    final jsonData = await _getJsonData('3/movie/$movieId/credits');

    final creditsResponsive = CreditsResponse.fromJson(jsonData);

    movieCast[movieId] = creditsResponsive.cast;

    return creditsResponsive.cast;
  }
}
