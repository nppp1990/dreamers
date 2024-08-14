// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      email: json['email'] as String?,
      password: json['password'] as String?,
      isSuperuser: json['is_superuser'] as bool?,
      isStaff: json['is_staff'] as bool?,
      provider: json['provider'] as String?,
      lastLogin: (json['last_login'] as num?)?.toInt(),
      dateJoined: (json['date_joined'] as num?)?.toInt(),
      phoneNumber: json['phone_number'] as String?,
      language: json['language'] as String?,
      createdAt: (json['created_at'] as num?)?.toInt(),
      updatedAt: (json['updated_at'] as num?)?.toInt(),
      deletedAt: (json['deleted_at'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'is_superuser': instance.isSuperuser,
      'is_staff': instance.isStaff,
      'provider': instance.provider,
      'last_login': instance.lastLogin,
      'date_joined': instance.dateJoined,
      'phone_number': instance.phoneNumber,
      'language': instance.language,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };

ProfileInfo _$ProfileInfoFromJson(Map<String, dynamic> json) => ProfileInfo(
      id: json['id'] as String,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      profileImage: json['profile_image'] as String?,
      genderIdentity: json['gender_identity'] as String?,
      targetGender: json['target_gender'] as String?,
      birthday: (json['birthday'] as num?)?.toInt(),
      about: json['about'] as String?,
      nickname: json['nickname'] as String?,
      age: (json['age'] as num?)?.toInt(),
      languages: json['languages'] as String?,
      livingCountry: json['living_country'] as String?,
      livingState: json['living_state'] as String?,
      education: json['education'] as String?,
      occupation: json['occupation'] as String?,
      height: json['height'] as String?,
      bodyType: json['body_type'] as String?,
      maritalStatus: json['marital_status'] as String?,
      relationshipGoal: json['relationship_goal'] as String?,
      createdAt: (json['created_at'] as num?)?.toInt(),
      updatedAt: (json['updated_at'] as num?)?.toInt(),
      deletedAt: (json['deleted_at'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProfileInfoToJson(ProfileInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'profile_image': instance.profileImage,
      'gender_identity': instance.genderIdentity,
      'target_gender': instance.targetGender,
      'birthday': instance.birthday,
      'about': instance.about,
      'nickname': instance.nickname,
      'age': instance.age,
      'languages': instance.languages,
      'living_country': instance.livingCountry,
      'living_state': instance.livingState,
      'education': instance.education,
      'occupation': instance.occupation,
      'height': instance.height,
      'body_type': instance.bodyType,
      'marital_status': instance.maritalStatus,
      'relationship_goal': instance.relationshipGoal,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
