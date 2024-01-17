import 'package:dartz/dartz.dart';
import 'package:job_marketplace/api/error/failures.dart';
import 'package:job_marketplace/api/remote_datasource.dart';
import 'package:job_marketplace/models/response/jobs/get_job.dart';
import 'package:job_marketplace/utils/network_info.dart';

import '../api/error/exception.dart';
import '../repositories/job_repository.dart';

class JobRepositoryImpl implements JobRepository {
  final NetworkInfoImpl networkInfoImpl;
  final RemoteDataSource remoteDataSource;

  JobRepositoryImpl({
    required this.networkInfoImpl,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<GetJobRes>>> getJobAll() async {
    if (await networkInfoImpl.isConnected) {
      try {
        final response = await remoteDataSource.getJobAll();
        if (response.data is List<GetJobRes>) {
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
  Future<Either<Failure, List<GetJobRes>>> getJobRecent() async {
    if (await networkInfoImpl.isConnected) {
      try {
        final response = await remoteDataSource.getJobAll();
        if (response.data is List<GetJobRes>) {
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
