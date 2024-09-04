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
  String? profileImage;
  @JsonKey(name: 'gender_identity')
  String? genderIdentity;
  @JsonKey(name: 'target_gender')
  String? targetGender;
  @JsonKey(name: 'phone_number')
  String? phoneNumber;
  int? birthday;
  String? about;
  String? nickname;
  @JsonKey(includeFromJson: false, includeToJson: false)
  int? age;
  String? languages;
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String>? languageList;
  @JsonKey(name: 'living_country')
  String? livingCountry;
  @JsonKey(name: 'living_state')
  String? livingState;
  String? education;
  String? occupation;
  String? height;
  @JsonKey(name: 'body_type')
  String? bodyType;
  @JsonKey(name: 'marital_status')
  String? maritalStatus;
  @JsonKey(name: 'relationship_goal')
  String? relationshipGoal;
  @JsonKey(name: 'created_at')
  final int? createdAt;
  @JsonKey(name: 'updated_at')
  final int? updatedAt;
  @JsonKey(name: 'deleted_at')
  final int? deletedAt;

  ProfileInfo(
      {required this.id,
      this.user,
      this.profileImage,
      this.genderIdentity,
      this.targetGender,
      this.phoneNumber,
      this.birthday,
      this.about,
      this.nickname,
      this.age,
      this.languages,
      this.languageList,
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

  ProfileInfo copy() {
    return ProfileInfo(
      id: id,
      user: user,
      profileImage: profileImage,
      genderIdentity: genderIdentity,
      targetGender: targetGender,
      phoneNumber: phoneNumber,
      birthday: birthday,
      about: about,
      nickname: nickname,
      age: age,
      languages: languages,
      languageList: languageList,
      livingCountry: livingCountry,
      livingState: livingState,
      education: education,
      occupation: occupation,
      height: height,
      bodyType: bodyType,
      maritalStatus: maritalStatus,
      relationshipGoal: relationshipGoal,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
    );
  }

  initLanguageList() {
    // "["abc"]" null ["English"] ["English", "Chinese"]
    if (languages == null || languages == 'null') {
      languageList = [];
    } else {
      languageList = (jsonDecode(languages!) as List).cast<String>();
    }
  }

  bool isDifferent(ProfileInfo other) {
    return jsonEncode(toJson()) != jsonEncode(other.toJson());
  }

  factory ProfileInfo.fromJson(Map<String, dynamic> json) => _$ProfileInfoFromJson(json)..initLanguageList();

  Map<String, dynamic> toJson() => _$ProfileInfoToJson(this)
    ..removeNullValues()
    // the backend expects the languages to json string
    ..['languages'] = jsonEncode(languageList)
    // the backend expects the user to be
    ..['user'] = user?.id;


  Map<String, dynamic> toJsonWithUser() => _$ProfileInfoToJson(this)..removeNullValues();

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
