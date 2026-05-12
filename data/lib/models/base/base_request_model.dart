import 'package:json_annotation/json_annotation.dart';
part 'base_request_model.g.dart';

@JsonSerializable()
class BaseRequestModel {
  @JsonKey(name: "baseClass")
  Map<String, dynamic>? baseData;

  BaseRequestModel({required this.baseData});

  factory BaseRequestModel.fromJson(Map<String, dynamic> json) => _$BaseRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseRequestModelToJson(this);
}
