import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:domain/constant/error_info.dart';
import 'package:domain/constant/error_type.dart';
import 'package:domain/errors/app_error.dart';
import 'package:domain/errors/base_error.dart';
import 'package:domain/usecase/base/params.dart';
import 'package:kick_stack/utils/resource.dart';

class RequestManager<T> {
  final StreamController<Resource<T>> _resource =
      StreamController<Resource<T>>();

  RequestManager(
    Params params, {
    required Future<Either<BaseError, T>> Function() createCall,
  }) {
    _execute(params, createCall);
  }

  Future<void> _execute(
    Params params,
    Future<Either<BaseError, T>> Function() createCall,
  ) async {
    _resource.sink.add(Resource.loading<T>(data: null));
    await params.verify().fold<Future<void>>(
      (l) async {
        _resource.sink.add(Resource.error<T>(error: l, data: null));
        dispose();
      },
      (r) async {
        try {
          final response = await createCall.call();
          response.fold(
            (l) {
              _resource.sink.add(Resource.error<T>(error: l.transform()));
              dispose();
            },
            (r) {
              _resource.sink.add(Resource.success<T>(data: r));
              dispose();
            },
          );
        } catch (error) {
          _resource.sink.add(
            Resource.error<T>(
              error: AppError(
                cause: Exception(error.toString()),
                error: ErrorInfo(message: error.toString()),
                type: ErrorType.IOEXCEPTION,
              ),
            ),
          );
          dispose();
        }
      },
    );
  }

  Stream<Resource<T>> asFlow() => _resource.stream;

  void dispose() {
    _resource.close();
  }
}
