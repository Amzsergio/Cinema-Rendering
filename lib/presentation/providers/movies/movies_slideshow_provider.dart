import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_cinema/domain/entities/movie.dart';
import 'package:http_cinema/presentation/providers/movies/movies_providers.dart';

final movieSlidesShowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];

  return nowPlayingMovies.sublist(0, 6);
});