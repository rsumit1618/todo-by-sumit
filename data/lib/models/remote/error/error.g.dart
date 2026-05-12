// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Error _$ErrorFromJson(Map<String, dynamic> json) => Error(
  (json['core'] as num).toInt(),
  json['message'] as String,
  json['msg'] as String,
  json['requestId'] as String,
);

Map<String, dynamic> _$ErrorToJson(Error instance) => <String, dynamic>{
  'core': instance.code,
  'message': instance.message,
  'msg': instance.msg,
  'requestId': instance.requestId,
};
