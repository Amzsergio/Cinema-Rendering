import 'package:dio/dio.dart';
import 'package:http_cinema/domain/datasources/actors_datasource.dart';
import 'package:http_cinema/domain/entities/actor.dart';
import 'package:http_cinema/infraestructure/mappers/actor_mapper.dart';
import 'package:http_cinema/infraestructure/models/moviedb/credits_response.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
  ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.actorToEntity(cast))
        .toList();

    return actors;
  }
}
