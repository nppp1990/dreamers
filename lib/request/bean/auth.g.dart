// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) => LoginResult(
      json['access'] as String?,
      json['refresh'] as String,
      json['user_id'] as String,
      json['user_profile_id'] as String,
    );

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'access': instance.access,
      'refresh': instance.refresh,
      'user_id': instance.userId,
      'user_profile_id': instance.userProfileId,
    };

LoginParam _$LoginParamFromJson(Map<String, dynamic> json) => LoginParam(
      json['email'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$LoginParamToJson(LoginParam instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

RefreshAccessResult _$RefreshAccessResultFromJson(Map<String, dynamic> json) =>
    RefreshAccessResult(
      json['access'] as String,
    );

Map<String, dynamic> _$RefreshAccessResultToJson(
        RefreshAccessResult instance) =>
    <String, dynamic>{
      'access': instance.access,
    };

RefreshAccessParam _$RefreshAccessParamFromJson(Map<String, dynamic> json) =>
    RefreshAccessParam(
      json['refresh_token'] as String,
    );

Map<String, dynamic> _$RefreshAccessParamToJson(RefreshAccessParam instance) =>
    <String, dynamic>{
      'refresh_token': instance.refresh,
    };
