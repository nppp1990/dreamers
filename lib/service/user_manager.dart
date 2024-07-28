class UserManager {
  static final UserManager _instance = UserManager._internal();

  factory UserManager() => _instance;

  UserManager._internal();

  isLogin() {
    // todo: 判断是否登录
    return true;
  }

// String _token;
// String get token => _token;
//
// void setToken(String token) {
//   _token = token;
// }
}
