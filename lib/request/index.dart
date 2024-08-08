import 'package:dio/dio.dart';
import 'package:dreamer/request/bean/auth.dart';
import 'package:dreamer/request/bean/user_profile.dart';
import 'package:retrofit/retrofit.dart';

part 'index.g.dart';

@RestApi(baseUrl: 'https://dreamer-dev.woyster.io/api/')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('auth/login')
  Future<LoginResult> login(@Body() LoginParam param);

  @POST('auth/refresh')
  Future<RefreshAccessResult> refreshAccess(@Body() RefreshAccessParam param);

  @GET('user-profiles/{id}')
  Future<ProfileInfo> getProfile(@Path('id') String id);
}
