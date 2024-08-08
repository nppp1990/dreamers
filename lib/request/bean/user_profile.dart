import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class User {
  // "id": "66b25951844c04b8f12c1d0f",
  // "email": "test2@divcord.com",
  // "password": "$2b$12$veMIVi9rKC.t52n7IjApNekd/yAekPG0MJNk.YKyN19Rcui0s4tum",
  // "is_superuser": false,
  // "is_staff": null,
  // "provider": null,
  // "last_login": null,
  // "date_joined": 1722964305243,
  // "phone_number": null,
  // "language": null,
  // "created_at": 1722964305243,
  // "updated_at": 1722964305243,
  // "deleted_at": null
  final String id;
  final String email;
  final String password;
  @JsonKey(name: 'is_superuser')
  final bool isSuperuser;
  @JsonKey(name: 'is_staff')
  final bool? isStaff;
  final String? provider;
  @JsonKey(name: 'last_login')
  final int? lastLogin;
  @JsonKey(name: 'date_joined')
  final int dateJoined;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final String? language;
  @JsonKey(name: 'created_at')
  final int createdAt;
  @JsonKey(name: 'updated_at')
  final int updatedAt;
  @JsonKey(name: 'deleted_at')
  final int? deletedAt;

  User(this.id, this.email, this.password, this.isSuperuser, this.isStaff, this.provider, this.lastLogin,
      this.dateJoined, this.phoneNumber, this.language, this.createdAt, this.updatedAt, this.deletedAt);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

@JsonSerializable()
class ProfileInfo {
  // "id": "66b25951844c04b8f12c1d10",
  // "profile_image": null,
  // "gender_identity": null,
  // "target_gender": null,
  // "birthday": null,
  // "about": null,
  // "nickname": null,
  // "age": null,
  // "langueages": "null",
  // "living_country": null,
  // "living_state": null,
  // "education": null,
  // "occupation": null,
  // "height": null,
  // "body_type": null,
  // "marital_status": null,
  // "relationship_goal": null,
  // "created_at": 1722964305578,
  // "updated_at": 1722964305578,
  // "deleted_at": null
  final String id;
  final User user;
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
  final int createdAt;
  @JsonKey(name: 'updated_at')
  final int updatedAt;
  @JsonKey(name: 'deleted_at')
  final int? deletedAt;

  ProfileInfo(
      {required this.id,
      required this.user,
      required this.profileImage,
      required this.genderIdentity,
      required this.targetGender,
      required this.birthday,
      required this.about,
      required this.nickname,
      required this.age,
      required this.languages,
      required this.livingCountry,
      required this.livingState,
      required this.education,
      required this.occupation,
      required this.height,
      required this.bodyType,
      required this.maritalStatus,
      required this.relationshipGoal,
      required this.createdAt,
      required this.updatedAt,
      required this.deletedAt});

  factory ProfileInfo.fromJson(Map<String, dynamic> json) => _$ProfileInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileInfoToJson(this);

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
