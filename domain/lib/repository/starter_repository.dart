import 'package:dartz/dartz.dart';
import 'package:domain/errors/network_error.dart';

abstract class StarterRepository {
  Future<Either<NetworkError, bool>> getDashboardSummary();
}
