import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_marketplace/injector_container.dart';
import 'package:job_marketplace/repositories/home_repository.dart';
import 'package:job_marketplace/repositories/job_repository.dart';
import 'package:job_marketplace/repositories_impl/home_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/response/auth/profile_model.dart';
import '../../models/response/jobs/get_job.dart';
import '../../repositories_impl/job_repository_impl.dart';
import '../../utils/result.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository = sl<HomeRepositoryImpl>();
  final JobRepository jobRepository = sl<JobRepositoryImpl>();
  HomeCubit() : super(const HomeState());

  void getUser() async {
    emit(state.copyWith(
      profileUpdateReq: Result.loading(),
    ));
    final id = sl<SharedPreferences>().getString('id');
    final response = await homeRepository.getUser(id ?? '');
    response.fold((failure) {
      emit(state.copyWith(
        profileUpdateReq: Result.error(failure.message),
      ));
    }, (result) async {
      emit(state.copyWith(
        profileUpdateReq: Result.completed(result),
      ));
    });
  }

  void getJobAll() async {
    emit(state.copyWith(getJobAllReq: Result.loading()));
    final response = await jobRepository.getJobAll();
    response.fold((failure) {
      emit(state.copyWith(
        getJobAllReq: Result.error(failure.message),
      ));
    }, (result) async {
      emit(state.copyWith(
        getJobAllReq: Result.completed(result),
      ));
    });
  }

  void getJobRecent() async {
    emit(state.copyWith(getJobRecent: Result.loading()));
    final response = await jobRepository.getJobRecent();
    response.fold((failure) {
      emit(state.copyWith(
        getJobRecent: Result.error(failure.message),
      ));
    }, (result) async {
      emit(state.copyWith(
        getJobRecent: Result.completed(result),
      ));
    });
  }
}
