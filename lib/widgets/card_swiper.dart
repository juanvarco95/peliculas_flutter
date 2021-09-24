import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';

// Se usa Widgets separados por carpetas para que sea más organizado
class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (this.movies.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.teal,
          ),
        ),
      );
    }

    return Container(
      // double.infinity: Se usa para usar el máximo que se pueda usar del padre
      width: double.infinity,
      height: size.height * 0.5,
      padding: EdgeInsets.only(top: 20),
      // Clase importada para hacer los Swipper
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.7,
        itemHeight: size.height * 0.5,
        // (_) => Se pone así para dar a enteder que se usa el context
        itemBuilder: (_, int index) {
          // GestureDetector: Para ejecutar el cambio de página
          final movie = movies[index];
          movie.heroId = 'swiper-${movie.id}';
          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(movie.fullPosterImage)),
              ),
            ),
          );
        },
      ),
    );
  }
}
