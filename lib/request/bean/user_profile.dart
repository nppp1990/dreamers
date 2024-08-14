import 'dart:convert';

import 'package:dreamer/common/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String? email;
  final String? password;
  @JsonKey(name: 'is_superuser')
  final bool? isSuperuser;
  @JsonKey(name: 'is_staff')
  final bool? isStaff;
  final String? provider;
  @JsonKey(name: 'last_login')
  final int? lastLogin;
  @JsonKey(name: 'date_joined')
  final int? dateJoined;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? language;
  @JsonKey(name: 'created_at')
  final int? createdAt;
  @JsonKey(name: 'updated_at')
  final int? updatedAt;
  @JsonKey(name: 'deleted_at')
  final int? deletedAt;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  User(
      {required this.id,
      this.email,
      this.password,
      this.isSuperuser,
      this.isStaff,
      this.provider,
      this.lastLogin,
      this.dateJoined,
      this.phoneNumber,
      this.language,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Map<String, dynamic> toJson() => _$UserToJson(this)..removeNullValues();

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

@JsonSerializable()
class ProfileInfo {
  final String id;
  final User? user;
  @JsonKey(name: 'profile_image')
  final String? profileImage;
  @JsonKey(name: 'gender_identity')
  final String? genderIdentity;
  @JsonKey(name: 'target_gender')
  final String? targetGender;
  final int? birthday;
  final String? about;
  final String? nickname;
  final int? age;
  final String? languages;
  @JsonKey(name: 'living_country')
  final String? livingCountry;
  @JsonKey(name: 'living_state')
  final String? livingState;
  final String? education;
  final String? occupation;
  final String? height;
  @JsonKey(name: 'body_type')
  final String? bodyType;
  @JsonKey(name: 'marital_status')
  final String? maritalStatus;
  @JsonKey(name: 'relationship_goal')
  final String? relationshipGoal;
  @JsonKey(name: 'created_at')
  final int? createdAt;
  @JsonKey(name: 'updated_at')
  final int? updatedAt;
  @JsonKey(name: 'deleted_at')
  final int? deletedAt;

  factory ProfileInfo.fromJson(Map<String, dynamic> json) => _$ProfileInfoFromJson(json);

  ProfileInfo(
      {required this.id,
      this.user,
      this.profileImage,
      this.genderIdentity,
      this.targetGender,
      this.birthday,
      this.about,
      this.nickname,
      this.age,
      this.languages,
      this.livingCountry,
      this.livingState,
      this.education,
      this.occupation,
      this.height,
      this.bodyType,
      this.maritalStatus,
      this.relationshipGoal,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Map<String, dynamic> toJson() => _$ProfileInfoToJson(this)..removeNullValues();

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
