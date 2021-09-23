import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CardActors extends StatelessWidget {
  final int movieId;
  const CardActors({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    // Se usa un future builder para solo cargar la información una vez y tenerla en memoria
    return FutureBuilder(
      future: moviesProvider.getCastMovies(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            height: 270,
            width: 190,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          // color: Colors.red,
          height: 270,
          width: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              itemBuilder: (_, index) {
                final actor = cast[index];
                // print(actor.profilePath);

                return Container(
                  margin: EdgeInsets.all(3),
                  width: 170,
                  // color: Colors.amber,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          placeholder: AssetImage('assets/no-image.jpg'),
                          image: NetworkImage(actor.fullProfilePath),
                          fit: BoxFit.cover,
                          width: 165,
                          height: 180,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                        width: 5,
                      ),
                      Text(
                        actor.name,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2,
                      )
                    ],
                  ),
                );
              }),
          // width: 100,
        );
      },
    );
  }
}
