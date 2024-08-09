import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class LoginResult {
  final String? access;
  final String refresh;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'user_profile_id')
  final String userProfileId;

  LoginResult(this.access, this.refresh, this.userId, this.userProfileId);

  factory LoginResult.fromJson(Map<String, dynamic> json) => _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);

  copyWith({String? access}) {
    return LoginResult(
      access,
      refresh,
      userId,
      userProfileId,
    );
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

@JsonSerializable()
class LoginParam {
  final String email;
  final String password;

  LoginParam(this.email, this.password);

  factory LoginParam.fromJson(Map<String, dynamic> json) => _$LoginParamFromJson(json);

  Map<String, dynamic> toJson() => _$LoginParamToJson(this);
}

@JsonSerializable()
class RefreshAccessResult {
  final String access;

  RefreshAccessResult(this.access);

  factory RefreshAccessResult.fromJson(Map<String, dynamic> json) => _$RefreshAccessResultFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshAccessResultToJson(this);
}

@JsonSerializable()
class RefreshAccessParam {
  @JsonKey(name: 'refresh_token')
  final String refresh;

  RefreshAccessParam(this.refresh);

  factory RefreshAccessParam.fromJson(Map<String, dynamic> json) => _$RefreshAccessParamFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshAccessParamToJson(this);
}

@JsonSerializable()
class SignUpParam {
  final String email;
  final String password;

  SignUpParam(this.email, this.password);

  factory SignUpParam.fromJson(Map<String, dynamic> json) => _$SignUpParamFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpParamToJson(this);
}