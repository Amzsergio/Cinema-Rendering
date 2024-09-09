import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_cinema/infraestructure/datasources/moviedb_datasource.dart';
import 'package:http_cinema/infraestructure/repositories/movies_repository_impl.dart';

final movieRepositoryProvider = Provider((ref) {
  return MoviesRepositoryImp(MoviedbDatasource());
});
