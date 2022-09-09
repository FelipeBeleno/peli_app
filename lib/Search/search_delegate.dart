import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:peli_app/models/models.dart';
import 'package:peli_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSeachDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => {close(context, null)}, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Build results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context);

    if (query.isEmpty) {
      return Container(
        child: Center(
          child: Icon(Icons.movie_creation_outlined,
              color: Colors.black38, size: 150),
        ),
      );
    }

    return FutureBuilder(
        future: movieProvider.serachMovie(query),
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) return Text('Hola');

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) =>
                _SuggestionItem(movie: data[index]),
          );
        });
  }
}

class _SuggestionItem extends StatelessWidget {
  final Movie movie;

  const _SuggestionItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'hola-como-estas${movie.id}';

    return Hero(
      tag: movie.heroId!,
      child: ListTile(
        leading: FadeInImage(
          image: NetworkImage(movie.fullPosteImg),
          placeholder: AssetImage('assets/loading.gif'),
          width: 50,
          fit: BoxFit.contain,
        ),
        title: Text(movie.title),
        subtitle: Text(movie.originalTitle),
        onTap: () =>
            {Navigator.pushNamed(context, 'details', arguments: movie)},
      ),
    );
  }
}
