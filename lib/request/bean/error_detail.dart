import 'package:json_annotation/json_annotation.dart';

part 'error_detail.g.dart';

@JsonSerializable()
class ErrorDetail {
  final String detail;

  ErrorDetail(this.detail);

  factory ErrorDetail.fromJson(Map<String, dynamic> json) => _$ErrorDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDetailToJson(this);
}