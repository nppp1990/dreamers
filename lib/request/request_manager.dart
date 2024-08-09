import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dreamer/request/base_result.dart';
import 'package:dreamer/request/bean/auth.dart';
import 'package:dreamer/request/bean/error_detail.dart';
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
    _dio.interceptors.add(TokenInterceptor(_dio));
    _dio.interceptors.add(LogInterceptor());
  }

  factory RequestManager() => _instance;

  BaseResult<T> _handleError<T>(error) {
    switch (error.runtimeType) {
      case const (DioException):
        final res = (error as DioException).response;
        if (res?.data is String) {
          return BaseResult<T>(error: error, errMsg: res?.data);
        }
        if (res?.data is Map) {
          ErrorDetail errorDetail = ErrorDetail.fromJson(res?.data);
          return BaseResult<T>(error: error, errMsg: errorDetail.detail);
        }
        return BaseResult<T>(error: error);
      default:
        return BaseResult<T>(error: Exception());
    }
  }

  Future<BaseResult<LoginResult>> login(String email, String password) async {
    final client = ApiClient(_dio);
    try {
      final LoginResult result = await client.login(LoginParam(email, password));
      return BaseResult(data: result);
    } catch (error) {
      return _handleError<LoginResult>(error);
    }
  }

  Future<ProfileInfo> getProfile(String? userProfileId) {
    final client = ApiClient(_dio);
    String id = userProfileId ?? UserManager().loginResult!.userProfileId;
    // if id is null, use the userProfileId from loginResult: it means get own profile
    return client.getProfile(id);
  }

  Future<RefreshAccessResult> refreshAccess() {
    final client = ApiClient(_dio);
    final refresh = UserManager().loginResult!.refresh;
    return client.refreshAccess(RefreshAccessParam(refresh));
  }

  Future<BaseResult<LoginResult>> signup(String email, String password) async {
    final client = ApiClient(_dio);
    try {
      final LoginResult result = await client.signUp(SignUpParam(email, password));
      return BaseResult(data: result);
    } catch (error) {
      return _handleError<LoginResult>(error);
    }
  }
}
