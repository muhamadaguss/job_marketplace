import 'package:dartz/dartz.dart';
import 'package:job_marketplace/api/error/exception.dart';
import 'package:job_marketplace/api/error/failures.dart';
import 'package:job_marketplace/models/request/auth/login_model.dart';
import 'package:job_marketplace/models/request/auth/profile_update_model.dart';
import 'package:job_marketplace/models/response/auth/login_res_model.dart';
import 'package:job_marketplace/models/response/auth/profile_model.dart';
import 'package:job_marketplace/utils/network_info.dart';

import '../api/remote_datasource.dart';
import '../repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final NetworkInfoImpl networkInfoImpl;
  final RemoteDataSource remoteDataSource;

  LoginRepositoryImpl({
    required this.networkInfoImpl,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, LoginResponseModel>> login(
      LoginModel loginModel) async {
    if (await networkInfoImpl.isConnected) {
      try {
        final response = await remoteDataSource.login(loginModel);
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

  @override
  Future<Either<Failure, ProfileRes>> updateUserInfo(
      ProfileUpdateReq profileModel, String id) async {
    if (await networkInfoImpl.isConnected) {
      try {
        final response =
            await remoteDataSource.updateUserInfo(profileModel, id);
        if (response.data is ProfileRes) {
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
