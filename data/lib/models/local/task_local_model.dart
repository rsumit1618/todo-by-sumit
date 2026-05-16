import 'package:domain/entities/task_entity.dart';

class TaskLocalModel {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  final String? userId;

  const TaskLocalModel({
    required this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
    this.userId,
  });

  factory TaskLocalModel.fromEntity(TaskEntity entity) {
    return TaskLocalModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      isCompleted: entity.isCompleted,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isSynced: entity.isSynced,
      userId: entity.userId,
    );
  }

  factory TaskLocalModel.fromRow(Map<String, dynamic> row) {
    return TaskLocalModel(
      id: row['id'] as String,
      title: row['title'] as String,
      description: row['description'] as String?,
      isCompleted: (row['is_completed'] as int) == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(row['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(row['updated_at'] as int),
      isSynced: (row['is_synced'] as int) == 1,
      userId: row['user_id'] as String?,
    );
  }

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isSynced: isSynced,
      userId: userId,
    );
  }

  Map<String, Object?> toSqlValues() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_completed': isCompleted ? 1 : 0,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'is_synced': isSynced ? 1 : 0,
      'user_id': userId,
    };
  }
}
