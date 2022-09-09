import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peli_app/models/models.dart';
import 'package:peli_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int id;

  const CastingCards({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: moviesProvider.getMovieCast(id),
        builder: ((_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
                child: CupertinoActivityIndicator(),
                width: double.infinity,
                height: 180);
          }
          final cast = snapshot.data!;

          return Container(
            width: double.infinity,
            height: 180,
            margin: EdgeInsets.only(top: 10, bottom: 30),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cast.length,
                itemBuilder: (_, int i) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 110,
                      height: 100,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                              height: 140,
                              width: 100,
                              fit: BoxFit.cover,
                              image: NetworkImage(cast[i].fullProfilePath),
                              placeholder: AssetImage('assets/loading.gif'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, top: 5),
                            child: Text(
                              cast[i].name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    )),
          );
        }));
  }
}
