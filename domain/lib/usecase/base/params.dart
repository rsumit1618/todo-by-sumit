import 'package:dartz/dartz.dart';
import 'package:domain/errors/app_error.dart';

abstract class Params {
  Either<AppError, bool> verify();
}
