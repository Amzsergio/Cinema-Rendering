import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_cinema/domain/entities/movie.dart';
import 'package:http_cinema/presentation/providers/movies/movies_repository_provider.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovie: movieRepository.getMovieById);
});

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier({
    required this.getMovie,
  }) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    log('se esta haciendo peticion http');

    final Movie movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}
