import 'dart:convert';
import 'package:data/models/remote/error/error_response_model.dart';
import 'package:dio/dio.dart';
import 'package:domain/constant/error_info.dart';
import 'package:domain/errors/network_error.dart';
import 'package:flutter/material.dart';

NetworkError getError({Response? apiResponse}) {
  if (apiResponse?.data != null) {
    try {
      final errorResponseEntity = ErrorResponseModel.fromJson((apiResponse?.data) is String
          ? jsonDecode(apiResponse?.data)
          : apiResponse?.data as Map<String, dynamic>);
      return NetworkError(
          httpError: apiResponse!.statusCode!,
          errorCode: errorResponseEntity.response!.content!,
          description: errorResponseEntity.response!.code.toString(),
          message: errorResponseEntity.response!.message.toString(),
          content: errorResponseEntity.response!.content.toString(),
          color: (errorResponseEntity.response!.code.toString()=='1')?ErrorColor.orange:ErrorColor.red,
          cause: Exception("Server Response Error"));
        } catch (exception) {
      debugPrint("I am in catch $exception");
      return NetworkError(
          cause: Exception("Server Response Error"),
          httpError: apiResponse!.statusCode!,
          message: apiResponse.statusMessage!);
    }
  } else {
    return NetworkError(
        cause: Exception("Server Response Error"),
        httpError: apiResponse!.statusCode!,
        message: apiResponse.statusMessage!);
  }
}
