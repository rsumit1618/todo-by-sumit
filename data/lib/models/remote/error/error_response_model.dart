import 'package:data/models/base/base_response_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_response_model.g.dart';

@JsonSerializable()
class ErrorResponseModel {
  @JsonKey(name: "response")
  final BaseResponseModel? response;

  ErrorResponseModel(this.response);

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return _$ErrorResponseModelFromJson(json);
  }
}
