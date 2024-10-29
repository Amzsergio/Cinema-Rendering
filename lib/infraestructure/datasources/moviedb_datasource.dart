import 'package:dio/dio.dart';
import 'package:http_cinema/config/constants/environment.dart';
import 'package:http_cinema/domain/datasources/movies_datasourse.dart';
import 'package:http_cinema/domain/entities/movie.dart';
import 'package:http_cinema/infraestructure/mappers/movie_mapper.dart';
import 'package:http_cinema/infraestructure/models/moviedb/movie_details.dart';
import 'package:http_cinema/infraestructure/models/moviedb/moviedb_response.dart';

class MoviedbDatasource extends MoviesDatasource {
  List<Movie> _jsonToMovie(Map<String, dynamic> json) {
    final moviedbResponse = MoviedbResponse.fromJson(json);

    final List<Movie> movies = moviedbResponse.results
        .where((moviedb) => moviedb.backdropPath != 'no-backdrop')
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.moviedbToEntity(moviedb))
        .toList();

    return movies;
  }

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX'
      },
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 12000),
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });

    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {
      'page': page,
    });
    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', queryParameters: {
      'page': page,
    });
    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {
      'page': page,
    });
    return _jsonToMovie(response.data);
  }

  @override
  Future<Movie> getMovieById(String movieId) async {
    final response = await dio.get('/movie/$movieId');
    if (response.statusCode != 200) {
      throw ('Not found movie $movieId');
    }

    final movieDb = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDb);

    return movie;
  }
}
