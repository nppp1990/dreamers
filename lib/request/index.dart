import 'package:dio/dio.dart';
import 'package:dreamer/request/bean/auth.dart';
import 'package:dreamer/request/bean/status.dart';
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

  @PUT('user-profiles/{id}')
  Future<ProfileInfo> updateProfile(@Path('id') String id, @Body() ProfileInfo profile);

  @POST('auth/signup')
  Future<LoginResult> signUp(@Body() SignUpParam param);

  @POST('auth/check')
  Future<ProfileInfo> checkAuth();

  @POST('verify/send-to-phone')
  Future<StatusResult> sendCodeToPhone(@Body() Map<String, dynamic> param);

  @POST('verify/check')
  Future<StatusResult> checkCode(@Body() Map<String, dynamic> param);
}
