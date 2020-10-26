import 'package:flutter/material.dart';
import 'package:movie_list/global.dart' as global;
import 'package:movie_list/movie_detail.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: global.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieList(),
    );
  }
}

class Movie {
  String title;
  String description;
  String posterPath;
  int id;

  Movie(String title, String description, int id, String posterPath) {
    this.title = title;
    this.description = description;
    this.posterPath = posterPath;
    this.id = id;
  }
}

class MovieList extends StatefulWidget {
  @override
  MovieListState createState() => MovieListState();
}

class MovieListState extends State<MovieList> {
  var movieRequests = [];
  List<Widget> movieButtons = new List<Widget>();

  Future<void> generateMovieList() async {
    await fetchPopularMovies();

    List<Widget> movieButtons = new List(this.movieRequests.length);
    for (int i = 0; i < movieRequests.length; i++) {
      movieButtons[i] = Card(
        child: InkWell(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(this.movieRequests[i]['title']),
          ),
          onTap: () => showMovieDetails(this.movieRequests[i]),
          highlightColor: Colors.lightBlueAccent,
          splashColor: Colors.lightBlue,
        ),
      );
    }

    setState(() {
      this.movieButtons = movieButtons;
    });
  }

  showMovieDetails(Map<String, dynamic> movieRequest) {
    Movie movie = new Movie(movieRequest['title'], movieRequest['overview'],
        movieRequest['id'], movieRequest['poster_path']);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MovieDetail(movie)),
    );
  }

  fetchPopularMovies() async {
    TMDB tmdb = TMDB(
      ApiKeys(global.apiKey, 'apiReadAccessTokenv4'),
    );
    try {
      Map response = await tmdb.v3.movies.getPouplar();
      setState(() {
        this.movieRequests = response['results'];
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.movieButtons.isEmpty) {
      generateMovieList();
    }

    return Scaffold(
      appBar: AppBar(title: Text(global.title)),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(8),
          children: this.movieButtons,
        ),
      ),
    );
  }
}
