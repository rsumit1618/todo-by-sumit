// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskDto _$TaskDtoFromJson(Map<String, dynamic> json) => TaskDto(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  isCompleted: json['isCompleted'] as bool,
  createdAt: (json['createdAt'] as num).toInt(),
  updatedAt: (json['updatedAt'] as num).toInt(),
  userId: json['userId'] as String?,
);

Map<String, dynamic> _$TaskDtoToJson(TaskDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'isCompleted': instance.isCompleted,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'userId': instance.userId,
};
