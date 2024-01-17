import 'package:dartz/dartz.dart';
import 'package:job_marketplace/api/error/failures.dart';
import 'package:job_marketplace/api/remote_datasource.dart';
import 'package:job_marketplace/models/request/auth/signup_model.dart';
import 'package:job_marketplace/models/response/auth/login_res_model.dart';
import 'package:job_marketplace/utils/network_info.dart';

import '../api/error/exception.dart';
import '../repositories/signup_repository.dart';

class SignupRepositoryImpl implements SignupRepository {
  final NetworkInfoImpl networkInfoImpl;
  final RemoteDataSource remoteDataSource;

  SignupRepositoryImpl({
    required this.networkInfoImpl,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, LoginResponseModel>> signup(
      SignupModel signupModel) async {
    if (await networkInfoImpl.isConnected) {
      try {
        final response = await remoteDataSource.signup(signupModel);
        if (response.data is LoginResponseModel) {
          return Right(response.data);
        } else {
          return const Left(ServerFailure());
        }
      } on ServerException catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(
        ServerFailure('Tidak ada koneksi internet'),
      );
    }
  }
}
