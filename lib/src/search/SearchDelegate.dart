import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate{
  
  final moviesProvider = new MoviesProvider();
  
  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions in appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon in the left of the appbar
    return IconButton(
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow,
      progress: transitionAnimation,),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      print('vacio');
      return Container();
    }else{
      print(query);
    return FutureBuilder(
      future: moviesProvider.getSearchList(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if(snapshot.hasData){
          final movies = snapshot.data;
          return ListView(
            children: movies.map((movie){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: (){
                  close(context,null);
                  movie.uniqueId = '';
                  Navigator.pushNamed(context, 'detail',arguments: movie);
                },
              );
            }).toList(),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        
      },
    );
  }
  }


}