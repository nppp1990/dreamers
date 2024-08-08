import 'package:dio/dio.dart';
import 'package:dreamer/service/user_manager.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final access = UserManager().loginResult?.access;
    if (access != null) {
      options.headers['Authorization'] = 'Bearer $access';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // set access to null
      UserManager().updateAccess(null);
      // refresh access
    }
    super.onError(err, handler);
  }
}