import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/movie_horizontal_widget.dart';


class HomePage extends StatelessWidget {
  
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        centerTitle: false,
        title: Text('Movies'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer(context)
          ],
        )
      )
     );
  }

  Widget _swiperCards(){

    return FutureBuilder(
      future: moviesProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if(snapshot.hasData){
            return CardSwiper(movies: snapshot.data);
          }else{
            return Container(
              child: Center(child: CircularProgressIndicator())
              );
          }
      }
    );

  } 

  Widget _footer(BuildContext context){

    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text('Populares', style: Theme.of(context).textTheme.subhead),
          FutureBuilder(
            future: moviesProvider.getPopular(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData){
            return MovieHorizontal(movies: snapshot.data,);
          }else{
            return CircularProgressIndicator();
          }
            },
          ),
        ],
      ),
    );

  }

}