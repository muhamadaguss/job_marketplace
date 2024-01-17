import 'package:dartz/dartz.dart';
import 'package:job_marketplace/api/error/failures.dart';
import 'package:job_marketplace/models/request/auth/login_model.dart';
import 'package:job_marketplace/models/request/auth/profile_update_model.dart';
import 'package:job_marketplace/models/response/auth/login_res_model.dart';
import 'package:job_marketplace/models/response/auth/profile_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginResponseModel>> login(LoginModel loginModel);
  Future<Either<Failure, ProfileRes>> updateUserInfo(
      ProfileUpdateReq profileModel, String id);
}
