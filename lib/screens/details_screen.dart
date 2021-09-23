import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatefulWidget {
  // Con esto se puede captura lo que se va a envíar desde card_swiper y movie_slider
  // Y de cualquier otra parde donde ser vayan a ejecutar esos argumentos

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie.title, movie.fullBackDropPath),
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterAndTitle(movie.title, movie.fullPosterImage,
                movie.originalTitle, movie.voteAverage),
            _TextDescription(movie.overview),
            CardActors(movieId: movie.id),
            // CardActors(),
            // CardActors(),
          ]))
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _description(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      width: double.infinity,
      // color: Colors.red,
      height: 250,
      child: Column(
        children: [
          Text(
            'prueba',
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ),
    );
  }
}

class _TextDescription extends StatelessWidget {
  // const _TextDescription({Key? key}) : super(key: key);
  final String descripcion;
  const _TextDescription(this.descripcion);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      width: double.infinity,
      // color: Colors.red,
      height: 260,
      child: Column(
        children: [
          Text(
            descripcion,
            textAlign: TextAlign.justify,
            maxLines: 11,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.subtitle1,
          )
        ],
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle(this.title, this.poster, this.originalTitle, this.vote);
  final poster;
  final String title;
  final String originalTitle;
  final double vote;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
                height: 180,
                width: 130,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(poster)),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            // color: Colors.amber,
            width: _width - 200,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  // 'Incididunt in ullamco proident anim occaecat incididunt et officia. Laborum incididunt aute id mollit adipisicing qui. Occaecat amet anim laboris adipisicing deserunt culpa eu occaecat sunt occaecat laborum nostrud. Sint Lorem eiusmod anim voluptate non occaecat. Minim anim nulla sunt laborum ex. Ullamco do nulla dolor commodo veniam ex irure. Consectetur et commodo consequat quis ex adipisicing enim dolor.',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_border,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(vote.toString(),
                        style: Theme.of(context).textTheme.subtitle1)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar(this.title, this.poster);
  final String title;
  final poster;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // centerTitle: true,
      // backgroundColor: Colors.orangeAccent,
      expandedHeight: 200,
      floating: false,
      pinned: true,

      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(bottom: 0),
        centerTitle: true,
        title: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(bottom: 10),
            width: double.infinity,
            color: Colors.black12,
            child: Text(
              title,
              style: TextStyle(fontSize: 20),
            )),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(poster),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
