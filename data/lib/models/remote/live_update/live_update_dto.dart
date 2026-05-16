import 'package:domain/entities/live_update_entity.dart';

class LiveUpdateDto {
  final String id;
  final String title;
  final DateTime updatedAt;

  const LiveUpdateDto({
    required this.id,
    required this.title,
    required this.updatedAt,
  });

  factory LiveUpdateDto.fromJson(Map<String, dynamic> json) {
    final updatedAt = DateTime.tryParse(json['updatedAt']?.toString() ?? '');
    return LiveUpdateDto(
      id: json['id'].toString(),
      title: json['title']?.toString() ?? '',
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  LiveUpdateEntity toEntity() {
    return LiveUpdateEntity(id: id, title: title, updatedAt: updatedAt);
  }
}
