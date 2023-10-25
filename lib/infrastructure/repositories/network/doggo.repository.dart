import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../utils/app.apis.dart';
import 'i.interface.repository.dart';

class DoggoRepository extends NetworkRepository {
  DoggoRepository();

  Future<Either<DioException, Response>> getAllBreeds() async => get(
        AppApis.getAllBreeds(),
      );

  Future<Either<DioException, Response>> getAllImagesByBreed(
          final String breed) async =>
      get(
        AppApis.getAllImagesByBreed(breed),
      );
}
