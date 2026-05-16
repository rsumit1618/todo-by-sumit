import 'package:domain/constant/error_info.dart';
import 'package:domain/constant/error_type.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/base_error.dart';

class NetworkError extends BaseError {
  NetworkError({
    required int httpError,
    String errorCode = '',
    String message = '',
    String content = '',
    required super.cause,
    String description = '',
    ErrorColor? color,
  }) : super(
         error: ErrorInfo(
           code: httpError,
           message: message.isEmpty ? _defaultMessage(httpError) : message,
           content: content.isEmpty ? errorCode : content,
           description: description,
           color: color,
         ),
       );

  @override
  String getFriendlyMessage() {
    return error.message;
  }

  @override
  AppError transform() {
    return AppError(error: error, cause: cause, type: _mapType(error.code));
  }

  static ErrorType _mapType(int? statusCode) {
    if (statusCode == null) return ErrorType.NETWORK;

    if (statusCode == 101) {
      return ErrorType.NET_NO_INTERNET_CONNECTION;
    }

    if (statusCode == 401) return ErrorType.UNAUTHORIZED_USER;
    if (statusCode == 403) return ErrorType.FORBIDDEN_403;

    if (statusCode >= 500 ||
        statusCode == 404 ||
        statusCode == 408 ||
        statusCode == 409 ||
        statusCode == 422 ||
        statusCode == 429 ||
        statusCode == 495) {
      return ErrorType.NET_SERVER_MESSAGE;
    }

    return ErrorType.NETWORK;
  }

  static String _defaultMessage(int statusCode) {
    return switch (statusCode) {
      101 => 'No internet connection',
      401 => 'Session expired',
      403 => 'Access denied',
      404 => 'Resource not found',
      408 => 'Request timeout',
      429 => 'Too many requests',
      495 => 'SSL certificate validation failed',
      >= 500 => 'Server error',
      _ => 'Network request failed',
    };
  }
}
