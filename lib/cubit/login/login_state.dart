part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool isObscureText;
  final bool isFirstTime;
  final Result<LoginResponseModel>? isLogin;
  final Result<ProfileRes>? isProfileUpdate;
  const LoginState({
    this.isObscureText = true,
    this.isFirstTime = true,
    this.isLogin,
    this.isProfileUpdate,
  });

  @override
  List<Object?> get props => [
        isObscureText,
        isFirstTime,
        isLogin,
        isProfileUpdate,
      ];

  LoginState copyWith({
    bool? isObscureText,
    bool? isFirstTime,
    Result<LoginResponseModel>? isLogin,
    Result<ProfileRes>? isProfileUpdate,
  }) {
    return LoginState(
      isObscureText: isObscureText ?? this.isObscureText,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      isLogin: isLogin ?? this.isLogin,
      isProfileUpdate: isProfileUpdate ?? this.isProfileUpdate,
    );
  }
}
