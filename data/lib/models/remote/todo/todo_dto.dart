import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/entities/todo_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_dto.g.dart';

@JsonSerializable()
class TodoDto {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final int createdAt;
  final int updatedAt;
  final String? userId;

  TodoDto({
    required this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
    this.userId,
  });

  factory TodoDto.fromEntity(TodoEntity entity) {
    return TodoDto(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
      createdAt: entity.createdAt.millisecondsSinceEpoch,
      updatedAt: entity.updatedAt.millisecondsSinceEpoch,
      userId: entity.userId,
    );
  }

  factory TodoDto.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    return TodoDto.fromJson({
      ...data,
      'id': data['id'] ?? document.id,
    });
  }

  factory TodoDto.fromJson(Map<String, dynamic> json) =>
      _$TodoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoDtoToJson(this);

  TodoEntity toEntity({bool isSynced = true}) {
    return TodoEntity(
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
