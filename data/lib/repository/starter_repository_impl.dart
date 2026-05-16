import 'package:dartz/dartz.dart';
import 'package:data/remote/utils/safe_api_call.dart';
import 'package:data/source/starter/network/starter_remote_data_source.dart';
import 'package:domain/errors/network_error.dart';
import 'package:domain/repository/starter_repository.dart';

class StarterRepositoryImpl extends StarterRepository {
  final StarterRemoteDataSource _starterRemoteDataSource;

  StarterRepositoryImpl(this._starterRemoteDataSource);

  @override
  Future<Either<NetworkError, bool>> getDashboardSummary() async {
    final response = await safeApiCall(
      _starterRemoteDataSource.getDashboardSummary(),
    );
    return response!.fold((l) => Left(l), (r) {
      return Right(r.isSuccessful());
    });
  }
}
