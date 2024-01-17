import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_marketplace/cubit/login/login_cubit.dart';
import 'package:job_marketplace/injector_container.dart';
import 'package:job_marketplace/models/request/auth/login_model.dart';
import 'package:job_marketplace/routes/app_pages.dart';
import 'package:job_marketplace/views/common/app_bar.dart';
import 'package:job_marketplace/views/common/custom_btn.dart';
import 'package:job_marketplace/views/common/custom_textfield.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/height_spacer.dart';
import 'package:job_marketplace/views/ui/auth/signup.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';

import '../../../cubit/zoom/zoom_cubit.dart';
import '../../../utils/result.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomAppBar(
          text: 'Login',
          child: SizedBox(),
        ),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listenWhen: (previous, current) =>
            previous.isLogin != current.isLogin ||
            previous.isFirstTime != current.isFirstTime,
        listener: (context, state) {
          if (state.isLogin?.status == Status.COMPLETED &&
              state.isFirstTime == true) {
            sl<ZoomCubit>().setIndex(0);
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.PERSONALDETAILS, (route) => false);
          } else if (state.isLogin?.status == Status.COMPLETED &&
              state.isFirstTime == false) {
            sl<ZoomCubit>().setIndex(0);
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.MAINSCREEN, (route) => false);
          } else if (state.isLogin?.status == Status.ERROR) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.isLogin?.message ?? 'Something went wrong'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        buildWhen: (previous, current) =>
            previous.isObscureText != current.isObscureText ||
            previous.isLogin != current.isLogin,
        builder: (context, state) {
          if (state.isLogin?.status == Status.LOADING) {
            return buildBody(true, state.isObscureText);
          } else {
            return buildBody(false, state.isObscureText);
          }
        },
      ),
    );
  }

  Widget buildBody(
    bool isLoading,
    bool? isObscureText,
  ) {
    return LoadingOverlay(
      isLoading: isLoading,
      opacity: 0.5,
      progressIndicator: Center(
        child: Lottie.asset('assets/json/loading.json'),
      ),
      color: Color(kLightGrey.value),
      child: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const HeightSpacer(size: 50),
              ReusableText(
                text: 'Welcome Back !',
                style: appstyle(
                  30,
                  Color(kDark.value),
                  FontWeight.w600,
                ),
              ),
              ReusableText(
                text: 'Fill the details to login your account',
                style: appstyle(
                  16,
                  Color(kDarkGrey.value),
                  FontWeight.w600,
                ),
              ),
              const HeightSpacer(size: 50),
              CustomTextField(
                controller: email,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const HeightSpacer(size: 20),
              CustomTextField(
                controller: password,
                hintText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                obscureText: isObscureText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    sl<LoginCubit>().toggleObscureText();
                  },
                  child: isObscureText == true
                      ? Icon(
                          CupertinoIcons.eye_slash_fill,
                          color: Color(kDarkGrey.value),
                        )
                      : Icon(
                          CupertinoIcons.eye_fill,
                          color: Color(kDarkGrey.value),
                        ),
                ),
              ),
              const HeightSpacer(size: 10),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegistrationPage(),
                      ),
                    );
                  },
                  child: ReusableText(
                    text: 'Register',
                    style: appstyle(
                      14,
                      Color(kDark.value),
                      FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const HeightSpacer(size: 50),
              CustomButton(
                text: 'Login',
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    sl<LoginCubit>().login(LoginModel(
                      email: email.text,
                      password: password.text,
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill the form'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
