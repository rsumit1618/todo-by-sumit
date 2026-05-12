import 'package:dartz/dartz.dart';
import 'package:data/remote/utils/safe_api_call.dart';
import 'package:data/source/user/network/user_repository_ds.dart';
import 'package:domain/errors/local_error.dart';
import 'package:domain/errors/local_storage_error.dart';
import 'package:domain/errors/network_error.dart';
import 'package:domain/repository/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
   final UserRepositoryDs _userRepositoryDs;

  UserRepositoryImpl(this._userRepositoryDs);

  @override
  Future<Either<LocalError, bool>> getUserNameFromLocalDB() {
    // TODO: implement getUserNameFromLocalDB
    throw UnimplementedError();
  }

  @override
  Future<Either<NetworkError, bool>> getUserNameFromLocalNetwork() async {
    final response = await safeApiCall(
      _userRepositoryDs.getUserNameFromLocalDB(),
    );
    return response!.fold((l) => Left(l), (r) {
      return Right(r.isSuccessful());
    });
  }

  @override
  Future<Either<LocalStorageError, bool>> getUserNameFromStorage() {
    // TODO: implement getUserNameFromStorage
    throw UnimplementedError();
  }
}