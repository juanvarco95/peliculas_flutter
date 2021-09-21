import 'package:flutter/material.dart';

class CardActors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      // color: Colors.red,
      height: 270,
      width: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (_, index) => Container(
          margin: EdgeInsets.all(3),
          width: 170,
          // color: Colors.amber,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage('https://via.placeholder.com/200x170'),
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
                'Veniam ipsum culpa dolore et quis qui.',
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle2,
              )
            ],
          ),
        ),
      ),
      // width: 100,
    );
  }
}
