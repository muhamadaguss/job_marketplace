import 'package:dartz/dartz.dart';
import 'package:job_marketplace/api/error/failures.dart';
import 'package:job_marketplace/models/response/auth/profile_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, ProfileRes>> getUser(String id);
}
