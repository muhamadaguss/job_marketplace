import 'package:job_marketplace/api/api_client.dart';
import 'package:job_marketplace/api/api_response.dart';
import 'package:job_marketplace/api/service_url.dart';
import 'package:job_marketplace/injector_container.dart';
import 'package:job_marketplace/models/request/auth/login_model.dart';
import 'package:job_marketplace/models/request/auth/profile_update_model.dart';
import 'package:job_marketplace/models/request/auth/signup_model.dart';
import 'package:job_marketplace/models/response/auth/login_res_model.dart';
import 'package:job_marketplace/models/response/auth/profile_model.dart';
import 'package:job_marketplace/models/response/jobs/get_job.dart';

class RemoteDataSource {
  final ApiClient apiClient = sl<ApiClient>();

  //post
  Future<ApiResponse<LoginResponseModel>> login(LoginModel loginModel) async {
    final response =
        await apiClient.post(ServiceUrl.login, data: loginModel.toJson());
    return ApiResponse.fromJson(response, LoginResponseModel.fromJson);
  }

  Future<ApiResponse<LoginResponseModel>> signup(
      SignupModel signupModel) async {
    final response =
        await apiClient.post(ServiceUrl.signup, data: signupModel.toJson());
    return ApiResponse.fromJson(response, LoginResponseModel.fromJson);
  }

  //put
  Future<ApiResponse<ProfileRes>> updateUserInfo(
      ProfileUpdateReq profileMode, String id) async {
    final response = await apiClient.put('${ServiceUrl.user}/$id',
        data: profileMode.toJson());
    return ApiResponse.fromJson(response, ProfileRes.fromJson);
  }

  //get
  Future<ApiResponse<ProfileRes>> getUser(String id) async {
    final response = await apiClient.get(
      '${ServiceUrl.user}/find/$id',
    );
    return ApiResponse.fromJson(response, ProfileRes.fromJson);
  }

  Future<ApiResponse<GetJobRes>> getJobAll() async {
    final response = await apiClient.get(
      ServiceUrl.job,
    );
    return ApiResponse.fromJson(response, GetJobRes.fromJson);
  }
}
