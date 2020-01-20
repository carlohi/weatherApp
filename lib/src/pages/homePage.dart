import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/search/SearchDelegate.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/movie_horizontal_widget.dart';


class HomePage extends StatelessWidget {
  
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopular();
    return Scaffold( 
      appBar: AppBar(
        centerTitle: false,
        title: Text('Movies'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon( Icons.search),
            onPressed: (){
              showSearch(context: context,delegate: DataSearch());
            },
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0) ,
            child: Text('Populares', style: Theme.of(context).textTheme.subhead)),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData){
            return MovieHorizontal(movies: snapshot.data,
            nextPage: moviesProvider.getPopular,);
          }else{
            return Center(child: CircularProgressIndicator());
          }
            },
          ),
        ],
      ),
    );
  }
}