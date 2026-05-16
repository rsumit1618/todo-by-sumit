import 'package:domain/constant/error_info.dart';
import 'package:domain/constant/error_type.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/base_error.dart';

class LocalError extends BaseError {
  LocalError({
    required String message,
    required int localError,
    required super.cause,
  }) : super(
         error: ErrorInfo(message: message, code: localError),
       );

  @override
  String getFriendlyMessage() {
    return error.message;
  }

  @override
  AppError transform() {
    switch (error.code) {
      case 1:
        return AppError(error: error, cause: cause, type: ErrorType.UI);
      default:
        return AppError(
          error: error,
          cause: cause,
          type: ErrorType.IOEXCEPTION,
        );
    }
  }
}
