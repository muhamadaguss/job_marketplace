import 'package:dartz/dartz.dart';
import 'package:job_marketplace/api/error/failures.dart';
import 'package:job_marketplace/models/response/jobs/get_job.dart';

abstract class JobRepository {
  Future<Either<Failure, List<GetJobRes>>> getJobAll();
  Future<Either<Failure, List<GetJobRes>>> getJobRecent();
}
