part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final bool isObscureText;
  final bool passwordValidator;
  final Result<LoginResponseModel>? result;
  const SignupState({
    this.isObscureText = true,
    this.passwordValidator = false,
    this.result,
  });

  @override
  List<Object?> get props => [isObscureText, passwordValidator, result];

  SignupState copyWith({
    bool? isObscureText,
    bool? passwordValidator,
    Result<LoginResponseModel>? result,
  }) {
    return SignupState(
      isObscureText: isObscureText ?? this.isObscureText,
      passwordValidator: passwordValidator ?? this.passwordValidator,
      result: result ?? this.result,
    );
  }
}
