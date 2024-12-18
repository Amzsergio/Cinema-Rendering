import 'package:animate_do/animate_do.dart';
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
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      height: 210,
      child: Swiper(
          viewportFraction: 0.8,
          scale: 0.9,
          pagination: SwiperPagination(
              margin: const EdgeInsets.only(bottom: 0),
              builder: DotSwiperPaginationBuilder(
                activeColor: colors.primary,
                color: colors.secondary,
              )),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return _Slide(movie: movies[index]);
          }),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Image.network(
                  'https://img.freepik.com/premium-vector/error-404-with-cute-blue-sticky-notes-mascot_152558-79971.jpg?w=740');
            },
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                );
              }
              return FadeIn(child: child);
            },
          ),
        ),
      ),
    );
  }
}
