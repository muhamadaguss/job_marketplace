import 'package:dartz/dartz.dart';
import 'package:job_marketplace/api/error/failures.dart';
import 'package:job_marketplace/models/request/auth/signup_model.dart';
import 'package:job_marketplace/models/response/auth/login_res_model.dart';

abstract class SignupRepository {
  Future<Either<Failure, LoginResponseModel>> signup(SignupModel signupModel);
}
