import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_marketplace/models/request/auth/signup_model.dart';
import 'package:job_marketplace/repositories/signup_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../injector_container.dart';
import '../../models/response/auth/login_res_model.dart';
import '../../repositories_impl/signup_repository_impl.dart';
import '../../utils/result.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepository signupRepository = sl<SignupRepositoryImpl>();
  SignupCubit() : super(const SignupState());

  void toggleObscureText() {
    emit(state.copyWith(
      isObscureText: !state.isObscureText,
    ));
  }

  void passwordValidator(String password) {
    if (password.isEmpty) {
      emit(state.copyWith(passwordValidator: false));
    } else {
      String pattern = r'^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#\$&\*])(?=.{6,})';
      RegExp regExp = RegExp(pattern);
      bool isValid = regExp.hasMatch(password);
      emit(state.copyWith(passwordValidator: isValid));
    }
  }

  void signup(SignupModel signupModel) async {
    emit(state.copyWith(result: Result.loading()));
    final response = await signupRepository.signup(signupModel);
    response.fold((failure) {
      emit(state.copyWith(
        result: Result.error(failure.message),
      ));
    }, (result) {
      sl<SharedPreferences>().setString('token', result.token);
      sl<SharedPreferences>().setString('id', result.id);
      sl<SharedPreferences>().remove('firstTime');
      sl<SharedPreferences>().setBool('firstTime', true);
      emit(state.copyWith(
        result: Result.completed(result),
      ));
    });
  }
}
