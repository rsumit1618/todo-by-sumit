import 'package:domain/constant/error_info.dart';
import 'package:domain/constant/error_type.dart';

class AppError implements Exception {
  ErrorType type;
  ErrorInfo error;
  Exception cause;

  AppError({required this.cause, required this.error, required this.type});
}
