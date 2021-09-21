import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

// Se usa Widgets separados por carpetas para que sea más organizado
class CardSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // double.infinity: Se usa para usar el máximo que se pueda usar del padre
      width: double.infinity,
      height: size.height * 0.5,
      padding: EdgeInsets.only(top: 20),
      // Clase importada para hacer los Swipper
      child: Swiper(
        itemCount: 10,
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.7,
        itemHeight: size.height * 0.5,
        // (_) => Se pone así para dar a enteder que se usa el context
        itemBuilder: (_, int index) {
          // GestureDetector: Para ejecutar el cambio de página
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage('https://via.placeholder.com/300x400')),
            ),
          );
        },
      ),
    );
  }
}
