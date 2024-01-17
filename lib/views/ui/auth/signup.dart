import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_marketplace/cubit/signup/signup_cubit.dart';
import 'package:job_marketplace/injector_container.dart';
import 'package:job_marketplace/models/request/auth/signup_model.dart';
import 'package:job_marketplace/utils/result.dart';
import 'package:job_marketplace/views/common/app_bar.dart';
import 'package:job_marketplace/views/common/custom_btn.dart';
import 'package:job_marketplace/views/common/custom_textfield.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/height_spacer.dart';
import 'package:job_marketplace/views/ui/auth/login.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';

import '../../../routes/app_pages.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    name.dispose();
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
          text: 'Register',
          child: SizedBox(),
        ),
      ),
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.result?.status == Status.COMPLETED) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.LOGIN, (route) => false);
          } else if (state.result?.status == Status.ERROR) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.result?.message ?? 'Something went wrong'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        buildWhen: (previous, current) =>
            previous.isObscureText != current.isObscureText ||
            previous.result != current.result,
        builder: (context, state) {
          if (state.result?.status == Status.LOADING) {
            return buildBody(true, state);
          } else {
            return buildBody(false, state);
          }
        },
      ),
    );
  }

  Widget buildBody(bool isLoading, SignupState state) {
    return LoadingOverlay(
      isLoading: isLoading,
      opacity: 0.5,
      progressIndicator: Center(
        child: Lottie.asset('assets/json/loading.json'),
      ),
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
                text: 'Hello, Welcome !',
                style: appstyle(
                  30,
                  Color(kDark.value),
                  FontWeight.w600,
                ),
              ),
              ReusableText(
                text: 'Fill the details to signup your an account',
                style: appstyle(
                  16,
                  Color(kDarkGrey.value),
                  FontWeight.w600,
                ),
              ),
              const HeightSpacer(size: 50),
              CustomTextField(
                controller: name,
                hintText: 'Full Name',
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid name';
                  }
                  return null;
                },
              ),
              const HeightSpacer(size: 20),
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  String pattern =
                      r'^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#\$&\*])(?=.{6,})';
                  RegExp regExp = RegExp(pattern);
                  if (!regExp.hasMatch(value)) {
                    return 'Please enter a valid password with at least 1 uppercase, 1 lowercase, 1 number, and 1 special character, and a minimum of 6 characters';
                  }

                  return null;
                },
                obscureText: state.isObscureText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    sl<SignupCubit>().toggleObscureText();
                  },
                  child: state.isObscureText == true
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
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                        (route) => false);
                  },
                  child: ReusableText(
                    text: 'Login',
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
                text: 'Sign Up',
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    sl<SignupCubit>().signup(
                      SignupModel(
                        username: name.text,
                        email: email.text,
                        password: password.text,
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
