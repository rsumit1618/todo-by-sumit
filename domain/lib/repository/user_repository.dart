import 'package:dartz/dartz.dart';
import 'package:domain/errors/local_error.dart';
import 'package:domain/errors/local_storage_error.dart';
import 'package:domain/errors/network_error.dart';

abstract class UserRepository {

  Future<Either<LocalStorageError, bool>> getUserNameFromStorage();

  Future<Either<LocalError, bool>> getUserNameFromLocalDB();

  Future<Either<NetworkError, bool>> getUserNameFromLocalNetwork();

}