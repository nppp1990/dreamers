import 'dart:io';

import 'package:flutter/material.dart';

final class Region {
  final String name;
  final String code;

  const Region(this.name, this.code);

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(json['name'], json['code']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }
}

// {
// "code": "RU",
// "name": "Russian Federation"
// "city":[
// {
// "code": "MOW",
// "name": "Moscow"
// },
// {
// "code": "SPE",
// "name": "Saint Petersburg"
// },
// ]
// },

final class Country {
  final String name;
  final String code;
  final List<Region>? city;

  const Country(this.name, this.code, this.city);

  factory Country.fromJson(Map<String, dynamic> json) {
    if (json['city'] != null && json['city'] is List) {
      List<Region> cities = (json['city'] as List<dynamic>).map((e){
        return Region.fromJson(e);
      }).toList();
      return Country(json['name'], json['code'], cities);
    }
    return Country(json['name'], json['code'], null);
  }
}

class SignupData with ChangeNotifier {
  String? phonePrefix;
  String? phoneNumber;
  String? nickname;
  Region? country;
  Region? city;
  String? genderIdentity;
  String? targetGender;
  int? birthday;
  File? profilePicture;

  SignupData();

  void setPhonePrefix(String prefix) {
    phonePrefix = prefix;
    notifyListeners();
  }

  void setPhoneNumber(String number) {
    phoneNumber = number;
    notifyListeners();
  }

  void setNickname(String name) {
    nickname = name;
    notifyListeners();
  }

  void setRegion(Region country, Region city) {
    this.country = country;
    this.city = city;
    notifyListeners();
  }

  void setGender(String genderIdentity, String? targetGender) {
    this.genderIdentity = genderIdentity;
    this.targetGender = targetGender;
    notifyListeners();
  }

  void setBirthday(int birthday) {
    this.birthday = birthday;
    notifyListeners();
  }

  void setProfilePicture(File file) {
    profilePicture = file;
    notifyListeners();
  }

  void clear() {
    phonePrefix = null;
    phoneNumber = null;
    nickname = null;
    country = null;
    city = null;
    genderIdentity = null;
    targetGender = null;
    birthday = null;
    profilePicture = null;
    notifyListeners();
  }

}
