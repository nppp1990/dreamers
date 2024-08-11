import 'package:dreamer/common/utils/local_storage.dart';
import 'package:dreamer/request/bean/auth.dart';
import 'package:flutter/material.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();

  static const keyLoginResult = 'login_result';
  static const keyProfileComplete = 'profile_complete';

  LoginResult? loginResult;

  factory UserManager() => _instance;

  UserManager._internal();

  void saveLoginResult(LoginResult result) {
    loginResult = result;
    LocalStorage.saveMap(keyLoginResult, result.toJson());
  }

  void updateAccess(String? access) {
    loginResult = loginResult!.copyWith(access: access);
    saveLoginResult(loginResult!);
  }

  Future<void> getLoginInfo() async {
    if (loginResult != null) {
      return;
    }
    final result = await LocalStorage.getMap(keyLoginResult);
    if (result != null) {
      loginResult = LoginResult.fromJson(result);
    }
  }

  void clearLoginInfo() {
    loginResult = null;
    saveProfileComplete(false);
    LocalStorage.removeData(keyLoginResult);
  }

  isLogin() {
    return loginResult != null;
  }

  void saveProfileComplete(bool complete) {
    LocalStorage.saveData(keyProfileComplete, complete);
  }

  Future<bool> getProfileComplete() async {
    return await LocalStorage.getData<bool>(keyProfileComplete) ?? false;
  }
}
