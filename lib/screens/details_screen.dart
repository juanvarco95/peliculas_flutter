import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  // Con esto se puede captura lo que se va a envíar desde card_swiper y movie_slider
  // Y de cualquier otra parde donde ser vayan a ejecutar esos argumentos

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? 'No movie';
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterAndTitle(),
            _TextDescription(),
            CardActors(),
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
            'Officia aute veniam pariatur do laborum et aliqua amet nulla magna sunt consectetur.Anim aliquip excepteur culpa anim ad est duis cillum minim cupidatat officia esse cupidatat. Ipsum elit laborum duis sunt enim enim id culpa aliqua sunt. Irure proident enim ullamco mollit velit ad ea irure incididunt sunt incididunt anim. Reprehenderit laboris ut duis duis veniam reprehenderit sit reprehenderit.',
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
            'Officia aute veniam pariatur do laborum et aliqua amet nulla magna sunt consectetur.Anim aliquip excepteur culpa anim ad est duis cillum minim cupidatat officia esse cupidatat. '
            'Ipsum elit laborum duis sunt enim enim id culpa aliqua sunt. Irure proident enim ullamco mollit velit ad ea irure incididunt sunt incididunt anim. Reprehenderit laboris ut duis duis veniam reprehenderit sit reprehenderit.'
            'Magna officia mollit magna est sit labore tempor dolor exercitation adipisicing culpa. Dolor sint irure officia sint nostrud laboris nostrud mollit pariatur id do. Nulla id exercitation proident nisi veniam sit ullamco. Enim velit esse aute dolore deserunt aute ea do incididunt eiusmod aliqua elit sit. Eiusmod Lorem magna sit tempor deserunt reprehenderit dolore nulla ad est. Ea in ipsum elit esse velit Lorem elit ipsum incididunt dolor dolor. Officia adipisicing ut adipisicing Lorem sunt officia sint reprehenderit occaecat nisi.',
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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
                height: 150,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage('https://via.placeholder.com/300x400')),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'movie.title',
                style: Theme.of(context).textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                'movie.original_name',
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_border,
                    size: 15,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('movie.voteAverage',
                      style: Theme.of(context).textTheme.caption)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
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
              'Movie.Title',
              style: TextStyle(fontSize: 20),
            )),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x200'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
