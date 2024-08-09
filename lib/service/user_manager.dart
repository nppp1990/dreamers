import 'package:dreamer/common/utils/local_storage.dart';
import 'package:dreamer/request/bean/auth.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();

  LoginResult? loginResult;


  factory UserManager() => _instance;

  UserManager._internal();

  void saveLoginResult(LoginResult result) {
    LocalStorage.saveMap('login_result', result.toJson());
  }

  void updateAccess(String? access) {
    loginResult = loginResult!.copyWith(access: access);
    saveLoginResult(loginResult!);
  }

  void getLoginInfo() async {
    if (loginResult != null) {
      return;
    }
    final result = await LocalStorage.getMap('login_result');
    if (result != null) {
      loginResult = LoginResult.fromJson(result);
    }
  }

  void clearLoginInfo() {
    loginResult = null;
    LocalStorage.removeData('login_result');
  }

  isLogin() {
    return loginResult != null;
  }
}
