import 'package:dio/dio.dart';
import 'package:http_cinema/config/constants/environment.dart';
import 'package:http_cinema/domain/datasources/movies_datasourse.dart';
import 'package:http_cinema/domain/entities/movie.dart';
import 'package:http_cinema/infraestructure/mappers/movie_mapper.dart';
import 'package:http_cinema/infraestructure/models/moviedb/moviedb_response.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });
    final moviedbResponse = MoviedbResponse.fromJson(response.data);

    final List<Movie> movies = moviedbResponse.results
        .where((moviedb) => moviedb.backdropPath != 'no-backdrop')
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.moviedbToEntity(moviedb))
        .toList();

    return movies;
  }
}
