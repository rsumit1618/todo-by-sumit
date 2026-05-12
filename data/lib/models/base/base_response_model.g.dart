// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseModel _$BaseResponseModelFromJson(Map<String, dynamic> json) =>
    BaseResponseModel(
      code: (json['core'] as num?)?.toInt(),
      content: json['content'],
      exceptionMessage: json['exceptionMessage'] as String?,
      message: json['message'] as String?,
      token: json['token'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$BaseResponseModelToJson(BaseResponseModel instance) =>
    <String, dynamic>{
      'core': instance.code,
      'message': instance.message,
      'token': instance.token,
      'content': instance.content,
      'exceptionMessage': instance.exceptionMessage,
      'id': instance.id,
    };
