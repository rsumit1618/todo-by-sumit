import 'package:domain/constant/error_info.dart';
import 'package:domain/constant/error_type.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/base_error.dart';

class LocalStorageError extends BaseError {
  LocalStorageError({
    required String message,
    required int localStorageError,
    required super.cause,
  }) : super(error: ErrorInfo(message: message, code: localStorageError));

  @override
  String getFriendlyMessage() {
    return error.message;
  }

  @override
  AppError transform() {
    switch (error.code) {
      case 1:
        return AppError(error: error, cause: cause, type: ErrorType.LOCAL_STORAGE_EMPTY);
      case 2:
        return AppError(error: error, cause: cause, type: ErrorType.LOCAL_STORAGE_EMPTY);
      default:
        return AppError(error: error, cause: cause, type: ErrorType.LOCAL_STORAGE_EMPTY);
    }
  }
}
