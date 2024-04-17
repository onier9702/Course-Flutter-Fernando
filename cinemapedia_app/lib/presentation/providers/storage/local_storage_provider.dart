
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_app/infrastructure/datasources/isar_datasource.dart';
import 'package:cinemapedia_app/infrastructure/repositories/local_isar_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalIsarRepositoryImpl(IsarDatasource());
});
