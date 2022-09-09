import 'package:flutter/material.dart';
import 'package:peli_app/Search/search_delegate.dart';
import 'package:peli_app/providers/movies_provider.dart';
import 'package:peli_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Peliculas en cine'),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => showSearch(
                    context: context, delegate: MovieSeachDelegate()),
                icon: Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //cards wipers
              CardSwiper(movies: moviesProvider.onDisplayMovies),
              // listado horizontal de peliculas
              MoviSlider(
                movies: moviesProvider.onDisplayPopularMovies,
                title: 'Populares!',
                onNextPage: () => moviesProvider.getOnDisplayPopularMovies(),
              )
            ],
          ),
        ));
  }
}
