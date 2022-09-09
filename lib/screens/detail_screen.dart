import 'package:flutter/material.dart';
import 'package:peli_app/models/models.dart';
import 'package:peli_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  //todo: cambiar por instancia de movie

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(title: movie.title, backdrop: movie.fullBackDropPath),
        SliverList(
            delegate: SliverChildListDelegate([
          _PosterAndTitle(movie: movie),
          _Overview(overview: movie.overview),
          _Overview(overview: movie.overview),
          CastingCards(id: movie.id)
        ]))
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final String title;
  final String backdrop;

  const _CustomAppBar({super.key, required this.title, required this.backdrop});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(2),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Text(
            title,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          image: NetworkImage(backdrop),
          placeholder: AssetImage('assets/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;
  const _PosterAndTitle({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;

    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosteImg),
                height: 150,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            width: size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: theme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movie.originalTitle,
                  style: theme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_outline,
                      color: Colors.yellow,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '${movie.voteAverage}',
                      style: theme.caption,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final String overview;

  const _Overview({Key? key, required this.overview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
