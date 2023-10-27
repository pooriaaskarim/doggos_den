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
    final String breed,
  ) async =>
      get(
        AppApis.getAllImagesByBreed(breed),
      );

  Future<Either<DioException, Response>> getRandomByBreed(
    final String breed,
  ) async =>
      get(
        AppApis.getRandomImagesByBreed(breed),
      );

  Future<Either<DioException, Response>> getAllImagesBySubBreed(
    final String breed,
    final String subBreed,
  ) async =>
      get(
        AppApis.getAllImagesBySubBreed(
          breed,
          subBreed,
        ),
      );

  Future<Either<DioException, Response>> getRandomBySubBreed(
    final String breed,
    final String subBreed,
  ) async =>
      get(
        AppApis.getRandomImagesBySubBreed(
          breed,
          subBreed,
        ),
      );
}
