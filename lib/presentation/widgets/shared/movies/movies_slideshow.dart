import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:http_cinema/domain/entities/movie.dart';

class MovieSlideshow extends StatelessWidget {
  final List<Movie> movies;
  const MovieSlideshow({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 210,
      child: Swiper(
          viewportFraction: 0.9,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _Slide(
              movie: movies[index],
            );
          }),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
