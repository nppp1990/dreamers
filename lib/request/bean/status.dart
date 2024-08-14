import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class StatusResult {
  final String? status;

  get isSuccess => status == 'success';

  StatusResult({this.status});

  factory StatusResult.fromJson(Map<String, dynamic> json) {
    return StatusResult(
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }
}