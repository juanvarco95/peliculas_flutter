import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

// Se debe extender del SearchDelegate para que se pueda usar para hacer la búsqueda
class MovieSearchDelegate extends SearchDelegate {
  // Para cambiar el Label del Search a la palabra que se desee
  @override
  String get searchFieldLabel => 'Buscar';

  // Está en al frente del Query en este caso para vaciar el query
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
  }

  // Botón de retroceso, se usa el close que es una función del searchDelegate
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: Icon(Icons.arrow_back_ios_new));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('');
  }

  Widget emptyContainer() {
    return Container(
      child: Center(
        child: Icon(
          Icons.movie_creation_outlined,
          size: 250,
        ),
      ),
    );
  }

  // Sugerencias de las búsquedas
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return emptyContainer();
    }
    // Para llamar al provider
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);

    // Se usa un future Builder porque se usa una petición http
    return StreamBuilder(
      // El future usa el moviesProvideer de la búsqueda
      stream: moviesProvider.suggestionStream,
      // buider obligatorio(Context, Snapshot) => Donde está la información del Query
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        // Sí el snapshot no tiene información envía el emptyContainer
        if (!snapshot.hasData) return emptyContainer();
        // Para hacer el llamado a la película
        final movies = snapshot.data!;
        // ListView
        return ListView.builder(
            itemCount: movies.length,
            // itemBuilder: (context, index) => Llamado a la función function(película[index])
            itemBuilder: (_, int index) => _SuggestionBuilder(
                movies[index],
                // Para usar el heroId ya que el tag/id debe ser siempre diferente
                '${movies[index].title} -$index- ${movies[index].id} '));
      },
    );
  }
}

class _SuggestionBuilder extends StatelessWidget {
  final Movie movie;
  final String heroId;

  const _SuggestionBuilder(this.movie, this.heroId);

  @override
  Widget build(BuildContext context) {
    movie.heroId = heroId;
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage(movie.fullPosterImage),
            width: 50,
            fit: BoxFit.contain),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
