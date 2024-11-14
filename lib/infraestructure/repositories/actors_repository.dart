import 'package:http_cinema/domain/datasources/actors_datasource.dart';
import 'package:http_cinema/domain/entities/actor.dart';
import 'package:http_cinema/domain/repositories/actors.repository.dart';

class ActorsRepositoryImp extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorsRepositoryImp(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }
}
