import 'package:dreamer/common/utils/local_storage.dart';
import 'package:dreamer/request/bean/auth.dart';
import 'package:dreamer/request/bean/user_profile.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();

  static const keyLoginResult = 'login_result';

  // static const keyProfileComplete = 'profile_complete';
  static const keySimpleProfile = 'simple_profile';

  LoginResult? loginResult;
  ProfileInfo? profileInfo;

  bool get profileComplete => profileInfo != null;

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

  Future<void> init() async {
    await _getLoginInfo();
    await _getSimpleProfile();
  }

  Future<void> _getLoginInfo() async {
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
    LocalStorage.clearAll();
    // saveProfileComplete(null);
    // LocalStorage.removeData(keyLoginResult);
  }

  isLogin() {
    return loginResult != null;
  }

  void saveProfileComplete(ProfileInfo? profileInfo) {
    if (profileInfo != null) {
      // LocalStorage.saveData(keyProfileComplete, true);
      LocalStorage.saveMap(keySimpleProfile, profileInfo.toJsonWithUser());
    } else {
      // LocalStorage.saveData(keyProfileComplete, false);
      LocalStorage.removeData(keySimpleProfile);
    }
  }

  Future<void> _getSimpleProfile() async {
    if (loginResult == null) {
      return;
    }
    if (profileInfo != null) {
      return;
    }
    final result = await LocalStorage.getMap(keySimpleProfile);
    if (result != null) {
      profileInfo = ProfileInfo.fromJson(result);
    }
  }
}
