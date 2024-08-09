import 'package:json_annotation/json_annotation.dart';

part 'error_detail.g.dart';

@JsonSerializable()
class ErrorDetail {
  final String? detail;
  final String? error;

  ErrorDetail(this.detail, this.error);

  factory ErrorDetail.fromJson(Map<String, dynamic> json) => _$ErrorDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDetailToJson(this);

  String? getErrorMessage() {
    return error ?? detail;
  }

  @override
  String toString() {
    return 'ErrorDetail{detail: $detail, error: $error}';
  }
}
