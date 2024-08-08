import 'package:dio/dio.dart';
import 'package:dreamer/request/bean/auth.dart';
import 'package:dreamer/request/bean/user_profile.dart';
import 'package:dreamer/request/index.dart';
import 'package:dreamer/request/interceptor.dart';
import 'package:dreamer/service/user_manager.dart';

class RequestManager {
  static const contentTypeJson = "application/json";
  static const contentTypeFormData = "multipart/form-data";
  static const contentTypeForm = "application/x-www-form-urlencoded";
  static final Dio _dio = Dio();

  static final RequestManager _instance = RequestManager._init();

  RequestManager._init() {
    _dio.interceptors.add(TokenInterceptor());
    _dio.interceptors.add(LogInterceptor());
  }

  factory RequestManager() => _instance;

  Future<LoginResult> login(String email, String password) async {
    final client = ApiClient(_dio);
    return client.login(LoginParam(email, password));
  }

  Future<ProfileInfo> getProfile(String? userProfileId) async {
    final client = ApiClient(_dio);
    String id = userProfileId ?? UserManager().loginResult!.userProfileId;
    // if id is null, use the userProfileId from loginResult: it means get own profile
    return client.getProfile(id);
  }
}
