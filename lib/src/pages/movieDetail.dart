import 'package:flutter/material.dart';
import 'package:movies/src/models/ActorsModel.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class MovieDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitle(movie),
                _description(movie),
                _createCast(movie)
              ]
            ),
          )
        ],
      ),
    );
  }

  Widget _createAppBar(Movie movie){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(movie.title
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle( Movie movie){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
            image: NetworkImage(movie.getPosterImg()),
            height: 150.0,
          ),
        ),
        SizedBox(width: 20.0),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(movie.title,overflow: TextOverflow.ellipsis),
              Text(movie.originalTitle, overflow: TextOverflow.ellipsis),
              Row(children: <Widget>[
                Icon(Icons.star_border),
                Text(movie.voteAverage.toString(),overflow: TextOverflow.ellipsis)
              ],)
            ],
          ),
        )
      ],),
    );
  }

  Widget _description(Movie movie){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
      child: Text(movie.overview,
      textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _createCast(Movie movie){
    final movieProvider = new MoviesProvider();
    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createPageViewActor(snapshot.data);
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createPageViewActor(List<Actor> actors){
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: actors.length,
        itemBuilder: ( context, i){
         return _actorCard(actors[i]);
        },
      ),
    );
  }

  Widget _actorCard(Actor actor){
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: FadeInImage(
                      image: NetworkImage(actor.getPhotoImg()),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
          ),
          Text(actor.name,overflow: TextOverflow.ellipsis,)
        ],
      ),
    );
  }


}