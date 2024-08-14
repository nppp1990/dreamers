import 'package:dio/dio.dart';
import 'package:dreamer/request/base_result.dart';
import 'package:dreamer/request/bean/auth.dart';
import 'package:dreamer/request/bean/error_detail.dart';
import 'package:dreamer/request/bean/status.dart';
import 'package:dreamer/request/bean/user_profile.dart';
import 'package:dreamer/request/index.dart';
import 'package:dreamer/request/interceptor.dart';
import 'package:dreamer/service/user_manager.dart';
import 'package:flutter/material.dart';

class RequestManager {
  static const contentTypeJson = "application/json";
  static const contentTypeFormData = "multipart/form-data";
  static const contentTypeForm = "application/x-www-form-urlencoded";
  static final Dio _dio = Dio();

  static final RequestManager _instance = RequestManager._init();

  RequestManager._init() {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
    );
    _dio.interceptors.add(TokenInterceptor(_dio));
    _dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  factory RequestManager() => _instance;

  BaseResult<T> _handleError<T>(error) {
    debugPrint('-----------error: ${error.toString()}');
    debugPrintStack(stackTrace: error.stackTrace, label: error.toString());
    debugPrint('-----------XXXXXXerror: ${error.toString()}');
    switch (error.runtimeType) {
      case const (DioException):
        print('-----1');
        final res = (error as DioException).response;
        print('-----2');
        if (res?.data is String) {
          debugPrint('error1----: ${res?.data}');
          return BaseResult<T>(error: error, errMsg: res?.data);
        }
        print('-----3: ${res?.data}');
        if (res?.data is Map) {
          if (res?.data['error'] is Map) {
            var errorRes = res?.data['error'];
            if (errorRes['message'] != null) {
              debugPrint('error2----: ${errorRes['message']}');
              // {"error":{"message":"Unauthorized","code":"Unauthorized"}}
              return BaseResult<T>(error: error, errMsg: errorRes['message']);
            }
            final errorDetail = ErrorDetail.fromJson(errorRes);
            debugPrint('error3----: ${errorDetail.getErrorMessage()}');
            return BaseResult<T>(error: error, errMsg: errorDetail.getErrorMessage());
          }
          ErrorDetail errorDetail = ErrorDetail.fromJson(res?.data);
          return BaseResult<T>(error: error, errMsg: errorDetail.getErrorMessage());
        }
        print('-----4');
        debugPrint('error4----: ${res?.data}');
        return BaseResult<T>(error: error);
      default:
        debugPrint('error5----: ${error.toString()}');
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

  Future<BaseResult<ProfileInfo>> getProfile(String? userProfileId) async {
    final client = ApiClient(_dio);
    try {
      String id = userProfileId ?? UserManager().loginResult!.userProfileId;
      // if id is null, use the userProfileId from loginResult: it means get own profile
      final ProfileInfo profileInfo = await client.getProfile(id);
      return BaseResult(data: profileInfo);
    } catch (error) {
      return _handleError<ProfileInfo>(error);
    }
  }

  Future<BaseResult<ProfileInfo>> updateProfile(ProfileInfo profileInfo) async {
    final client = ApiClient(_dio);
    try {
      String id = UserManager().loginResult!.userProfileId;
      final ProfileInfo res = await client.updateProfile(id, profileInfo);
      return BaseResult(data: res);
    } catch (error) {
      return _handleError<ProfileInfo>(error);
    }
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

  Future<BaseResult<ProfileInfo>> checkAuth() async {
    final client = ApiClient(_dio);
    try {
      final ProfileInfo profileInfo = await client.checkAuth();
      return BaseResult(data: profileInfo);
    } catch (error) {
      return _handleError<ProfileInfo>(error);
    }
  }

  Future<BaseResult<StatusResult>> sendCodeToPhone(String prefix, String phoneNumber) async {
    final client = ApiClient(_dio);
    try {
      // mock data
      var res = await Future.delayed(const Duration(seconds: 1), () {
        return StatusResult(status: 'success');
      });
      // var res = await client.sendCodeToPhone({'phone_number': prefix + phoneNumber});
      return BaseResult(data: res);
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<BaseResult<StatusResult>> checkCode(String code) async {
    final client = ApiClient(_dio);
    try {
      // mock data
      var res = await Future.delayed(const Duration(seconds: 2), () {
        return StatusResult(status: 'success');
      });
      // var res = await client.checkCode({'phone_number': prefix + phoneNumber, 'code': code});
      return BaseResult(data: res);
    } catch (error) {
      return _handleError(error);
    }
  }
}
