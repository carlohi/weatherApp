import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Movie> movies;

  MovieHorizontal({@required this.movies});

  @override
  Widget build(BuildContext context) {
    
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height*0.2,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3
        ),
        children: _cards(),
      ),
    );
  }

 List<Widget> _cards(){
   return movies.map( (movie){
     return Container(
       margin: EdgeInsets.only(right: 15.0),
       child: Column(
         children: <Widget>[
           FadeInImage(
             image: NetworkImage(movie.getPosterImg()),
             placeholder: AssetImage('assets/img/no-image.jpg'),
             fit: BoxFit.cover, 
             height: 120.0,
           )
         ],
       )
     );
   }).toList();
 }


}