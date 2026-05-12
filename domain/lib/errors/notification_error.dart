

import 'package:domain/constant/error_info.dart';
import 'package:domain/constant/error_type.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/base_error.dart';

class PushNotificationError extends BaseError {
  PushNotificationError({
    required String message,
    required int pushNotificationError,
    required super.cause,
  }) : super(error: ErrorInfo(message: message, code: pushNotificationError));

  @override
  String getFriendlyMessage() {
    return error.message;
  }

  @override
  AppError transform() {
    return AppError(error: error, cause: cause, type: ErrorType.PUSH_NOTIFICATION_ERROR);
  }
}