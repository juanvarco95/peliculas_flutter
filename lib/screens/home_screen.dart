import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Acciones posibles dentro el AppBar
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search_outlined))
          ],
          title: Text(
            'Home',
            style: TextStyle(fontSize: 22, height: 1.5),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardSwiper(),
              SizedBox(
                height: 10,
              ),
              MovieSliders(),
            ],
          ),
        ));
  }
}
