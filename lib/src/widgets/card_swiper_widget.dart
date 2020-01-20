import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  CardSwiper({ @required this.movies});

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top:10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.8,
        itemHeight: _screenSize.height * 0.5,
          itemBuilder: (BuildContext context,int index){
            return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              child: FadeInImage(
                image: NetworkImage(movies[index].getPosterImg()),
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/img/no-image.jpg'),
              ),
            );
            
          },
          itemCount: movies.length,
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
        ),
    );
  }
}