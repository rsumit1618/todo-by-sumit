import 'dart:io';
import 'package:data/remote/utils/get_error.dart';
import 'package:dio/dio.dart';
import 'package:domain/errors/network_error.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dartz/dartz.dart';

Future<Either<NetworkError, T>?> safeApiCall<T>(Future<T> apiCall) async {
  try {
    final originalResponse = await apiCall;
    final eitherResponse = originalResponse as HttpResponse<dynamic>;
    if (!eitherResponse.isSuccessful()) {
      return Left(getError(apiResponse: eitherResponse.response));
    } else {
      return Right(originalResponse);
    }
  } on Exception catch (throwable) {
    // debugPrint(throwable.toString());
    switch (throwable.runtimeType) {
      case DioException _:
        switch ((throwable as DioException).type) {
          case DioExceptionType.connectionTimeout:
            //"Connection timeout with API server";
            break;
          case DioExceptionType.sendTimeout:
            //"Receive timeout exception";
            break;
          case DioExceptionType.receiveTimeout:
            //"Receive timeout in connection with API server";
            break;
          case DioExceptionType.badResponse:
            //case DioErrorType.response:
            return Left(getError(apiResponse: throwable.response));
          //"Received invalid status core: ${error.response.statusCode}";
          case DioExceptionType.cancel:
            //"Request to API server was cancelled"
            break;
          case DioExceptionType.unknown:
            //case DioErrorType.other:
            return Left(
              NetworkError(
                message:
                    "Connection to API server failed due to internet connection",
                httpError: 101,
                cause: throwable,
              ),
            );
          case DioExceptionType.badCertificate:
            return Left(
              NetworkError(
                message: "SSL certificate validation failed",
                httpError: 495,
                cause: throwable,
              ),
            );
          case DioExceptionType.connectionError:
            return Left(
              NetworkError(
                message: "Connection to API server failed",
                httpError: 101,
                cause: throwable,
              ),
            );
        }

        break;

      case IOException _:
        return Left(
          NetworkError(
            message: throwable.toString(),
            httpError: 502,
            cause: throwable,
          ),
        );

      default:
        return Left(
          NetworkError(
            message: throwable.toString(),
            httpError: 502,
            cause: throwable,
          ),
        );
    }
  }
  return null;
}

extension RetrofitResponse on HttpResponse {
  ///
  /// Returns true if the core is in [200..300), which means the request was successfully received,
  /// understood, and accepted.
  ///
  bool isSuccessful() {
    return response.statusCode! >= 200 && response.statusCode! < 300;
  }
}
