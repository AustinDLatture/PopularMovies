import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_list/global.dart' as global;
import 'package:movie_list/main.dart';

class MovieDetail extends StatefulWidget {
  String title;
  String description;
  String posterPath;
  int id;

  MovieDetail(Movie movie) {
    this.title = movie.title;
    this.description = movie.description;
    this.posterPath = movie.posterPath;
    this.id = movie.id;
  }

  @override
  MovieDetailState createState() => MovieDetailState();
}

class MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          children: [
            Image.network(global.posterPrefix + widget.posterPath,
                fit: BoxFit.fitWidth),
            Text(widget.description),
          ],
        ),
      ),
    );
  }
}
