import 'dart:convert';
import 'package:data/models/remote/error/error_response_model.dart';
import 'package:dio/dio.dart';
import 'package:domain/constant/error_info.dart';
import 'package:domain/errors/network_error.dart';

NetworkError getError({Response? apiResponse}) {
  final statusCode = apiResponse?.statusCode ?? 0;
  if (apiResponse?.data != null) {
    try {
      final errorResponseEntity = ErrorResponseModel.fromJson(
        (apiResponse?.data) is String
            ? jsonDecode(apiResponse?.data)
            : apiResponse?.data as Map<String, dynamic>,
      );
      final response = errorResponseEntity.response;
      return NetworkError(
        httpError: statusCode,
        errorCode: response?.content?.toString() ?? '',
        description: response?.code?.toString() ?? '',
        message: response?.message?.toString() ?? '',
        content: response?.content?.toString() ?? '',
        color: (response?.code?.toString() == '1')
            ? ErrorColor.orange
            : ErrorColor.red,
        cause: Exception("Server Response Error"),
      );
    } catch (exception) {
      return NetworkError(
        cause: Exception("Server Response Error"),
        httpError: statusCode,
        message: apiResponse?.statusMessage ?? '',
      );
    }
  } else {
    return NetworkError(
      cause: Exception("Server Response Error"),
      httpError: statusCode,
      message: apiResponse?.statusMessage ?? '',
    );
  }
}
