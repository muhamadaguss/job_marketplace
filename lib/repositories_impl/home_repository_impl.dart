import 'package:dartz/dartz.dart';

import 'package:job_marketplace/api/error/failures.dart';

import 'package:job_marketplace/models/response/auth/profile_model.dart';

import '../api/error/exception.dart';
import '../api/remote_datasource.dart';
import '../repositories/home_repository.dart';
import '../utils/network_info.dart';

class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfoImpl networkInfoImpl;
  final RemoteDataSource remoteDataSource;

  HomeRepositoryImpl({
    required this.networkInfoImpl,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, ProfileRes>> getUser(String id) async {
    if (await networkInfoImpl.isConnected) {
      try {
        final response = await remoteDataSource.getUser(id);
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
