import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class NetworkRepository {
  NetworkRepository();

  final Dio _client = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ),
  )..interceptors.addAll([
      PrettyDioLogger(
        responseHeader: true,
        responseBody: true,
        requestHeader: true,
        requestBody: true,
        request: true,
        error: true,
      ),
    ]);

  Future<Either<DioException, Response>> get<T>(
    final String api, {
    final Map<String, dynamic>? headers,
    final Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final Response<T> response = await _client.get<T>(
        api,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      return right(response);
    } on DioException catch (e) {
      return left(e);
    }
  }

  // Future<Either<DioException, Response>> post<T>(
  //   final String api, {
  //   final Map<String, dynamic>? headers,
  //   final Map<String, dynamic>? queryParameters,
  //   final Object? body,
  // }) async {
  //   try {
  //     final Response<T> response = await _client.post<T>(
  //       api,
  //       options: Options(headers: headers),
  //       queryParameters: queryParameters,
  //       data: body,
  //     );
  //     return right(response);
  //   } on DioException catch (e) {
  //     return left(e);
  //   }
  // }
  //
  // Future<Either<DioException, Response>> put<T>(
  //   final String api, {
  //   final Map<String, dynamic>? headers,
  //   final Map<String, dynamic>? queryParameters,
  //   final Object? body,
  // }) async {
  //   try {
  //     final Response<T> response = await _client.put<T>(
  //       api,
  //       options: Options(headers: headers),
  //       queryParameters: queryParameters,
  //       data: body,
  //     );
  //     return right(response);
  //   } on DioException catch (e) {
  //     return left(e);
  //   }
  // }
  //
  // Future<Either<DioException, Response>> patch<T>(
  //   final String api, {
  //   final Map<String, dynamic>? headers,
  //   final Map<String, dynamic>? queryParameters,
  //   final Object? body,
  // }) async {
  //   try {
  //     final Response<T> response = await _client.patch<T>(
  //       api,
  //       options: Options(headers: headers),
  //       queryParameters: queryParameters,
  //       data: body,
  //     );
  //     return right(response);
  //   } on DioException catch (e) {
  //     return left(e);
  //   }
  // }
  //
  // Future<Either<DioException, Response>> delete<T>(
  //   final String api, {
  //   final Map<String, dynamic>? headers,
  //   final Map<String, dynamic>? queryParameters,
  //   final Object? body,
  // }) async {
  //   try {
  //     final Response<T> response = await _client.delete<T>(
  //       api,
  //       options: Options(headers: headers),
  //       queryParameters: queryParameters,
  //       data: body,
  //     );
  //     return right(response);
  //   } on DioException catch (e) {
  //     return left(e);
  //   }
  // }
}

extension DioExceptionX on DioException {
  Map<String, dynamic>? get errors {
    if (response?.statusCode == 422) {
      return response?.data['errors'];
    }
    return null;
  }
}
