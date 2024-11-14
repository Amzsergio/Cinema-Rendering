import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_cinema/infraestructure/datasources/actor_moviedb_datasource.dart';
import 'package:http_cinema/infraestructure/repositories/actors_repository.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorsRepositoryImp(ActorMoviedbDatasource());
});
