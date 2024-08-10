import 'package:dio/dio.dart';
import 'package:dreamer/common/router/router_utils.dart';
import 'package:dreamer/main.dart';
import 'package:dreamer/page/login/login.dart';
import 'package:dreamer/request/request_manager.dart';
import 'package:dreamer/service/user_manager.dart';
import 'package:flutter/widgets.dart';

class TokenInterceptor extends Interceptor {
  final Dio _dio;

  TokenInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final access = UserManager().loginResult?.access;
    if (access != null && options.headers['Authorization'] == null) {
      options.headers['Authorization'] = 'Bearer $access';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async{
    if (err.response?.statusCode == 401) {
      // set access to null
      UserManager().updateAccess(null);
      // refresh access
      try {
        final access = (await RequestManager().refreshAccess()).access;
        debugPrint('refresh access: $access');
        // mock exception
        // throw DioException(requestOptions: err.requestOptions, response: Response(requestOptions: err.requestOptions, statusCode: 401));
        UserManager().updateAccess(access);

        // retry request
        err.requestOptions.headers['Authorization'] = 'Bearer $access';
        final response = await _dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        // if refresh failed, clear login info
        UserManager().clearLoginInfo();
        // reject request and goto login page
        navigatorKey.currentState?.pushAndRemoveUntil(NoAnimRouter(child: const LoginPage()), (route) => false);
        return handler.reject(err);
      }
    }
    super.onError(err, handler);
  }
}