import 'package:json_annotation/json_annotation.dart';

part 'base_response_model.g.dart';

@JsonSerializable()
class BaseResponseModel {
  @JsonKey(name: "core")
  final int? code;
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;
  @JsonKey(name: "content")
  final dynamic content;
  @JsonKey(name: "exceptionMessage")
  final String? exceptionMessage;
  @JsonKey(name: "id")
  final String? id;

  BaseResponseModel(
      {this.code,
        this.content,
        this.exceptionMessage,
        this.message,
        this.token,
        this.id,
        });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) => _$BaseResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseModelToJson(this);
}