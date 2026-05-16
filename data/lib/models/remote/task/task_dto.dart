import 'package:domain/entities/task_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_dto.g.dart';

@JsonSerializable()
class TaskDto {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final int createdAt;
  final int updatedAt;
  final String? userId;

  TaskDto({
    required this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
    this.userId,
  });

  factory TaskDto.fromEntity(TaskEntity entity) {
    return TaskDto(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
      createdAt: entity.createdAt.millisecondsSinceEpoch,
      updatedAt: entity.updatedAt.millisecondsSinceEpoch,
      userId: entity.userId,
    );
  }

  factory TaskDto.fromJson(Map<String, dynamic> json) =>
      _$TaskDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDtoToJson(this);

  TaskEntity toEntity({bool isSynced = true}) {
    return TaskEntity(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(updatedAt),
      isSynced: isSynced,
      userId: userId,
    );
  }
}
