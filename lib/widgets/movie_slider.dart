import 'package:flutter/material.dart';
import 'package:peli_app/models/movie_response.dart';

class MoviSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MoviSlider(
      {Key? key, required this.movies, required this.onNextPage, this.title})
      : super(key: key);

  @override
  State<MoviSlider> createState() => _MoviSliderState();
}

class _MoviSliderState extends State<MoviSlider> {
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (this.widget.title != null)
            Padding(
                padding: EdgeInsets.only(left: 20, bottom: 10),
                child: Text(widget.title!,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          Expanded(
            child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.movies.length,
                itemBuilder: (_, int i) =>
                    _MoviePoster(peli: widget.movies[i])),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie peli;

  const _MoviePoster({super.key, required this.peli});

  @override
  Widget build(BuildContext context) {
    peli.heroId = 'swiper-horizontal${peli.id}';

    return Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: peli),
            child: Hero(
              tag: peli.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                    width: 130,
                    height: 190,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(peli.fullPosteImg)),
              ),
            ),
          ),
          Text(
            peli.title,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
