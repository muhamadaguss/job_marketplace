import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_marketplace/cubit/home/home_cubit.dart';
import 'package:job_marketplace/injector_container.dart';
import 'package:job_marketplace/models/request/auth/login_model.dart';
import 'package:job_marketplace/models/request/auth/profile_update_model.dart';
import 'package:job_marketplace/repositories/login_repository.dart';
import 'package:job_marketplace/repositories_impl/login_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/response/auth/login_res_model.dart';
import '../../models/response/auth/profile_model.dart';
import '../../utils/result.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository loginRepository = sl<LoginRepositoryImpl>();
  LoginCubit() : super(const LoginState());

  void toggleObscureText() {
    emit(state.copyWith(
      isObscureText: !state.isObscureText,
    ));
  }

  void login(LoginModel model) async {
    emit(state.copyWith(isLogin: Result.loading()));
    final result = await loginRepository.login(model);
    result.fold((failure) {
      emit(state.copyWith(
        isLogin: Result.error(failure.message),
      ));
    }, (result) {
      sl<SharedPreferences>().setString('token', result.token);
      sl<SharedPreferences>().setString('id', result.id);
      sl<SharedPreferences>().setBool('isLogin', true);
      emit(state.copyWith(
        isLogin: Result.completed(result),
        isFirstTime: result.isFirstTime,
      ));
    });
  }

  void updateProfile(ProfileUpdateReq model) async {
    emit(state.copyWith(isProfileUpdate: Result.loading()));
    final id = sl<SharedPreferences>().getString('id');
    final result = await loginRepository.updateUserInfo(model, id ?? '');
    result.fold((failure) {
      emit(state.copyWith(
        isProfileUpdate: Result.error(failure.message),
      ));
    }, (result) async {
      sl<HomeCubit>().getUser();
      emit(state.copyWith(
        isProfileUpdate: Result.completed(result),
      ));
    });
  }

  void logout() async {
    emit(state.copyWith(isLogin: Result.loading()));
    sl<SharedPreferences>().remove('token');
    sl<SharedPreferences>().remove('id');
    sl<SharedPreferences>().setBool('isLogin', false);
    emit(state.copyWith(
      isLogin: Result.completed(null),
    ));
  }
}
