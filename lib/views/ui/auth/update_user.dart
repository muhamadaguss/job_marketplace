import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_marketplace/cubit/image/image_cubit.dart';
import 'package:job_marketplace/injector_container.dart';
import 'package:job_marketplace/models/request/auth/profile_update_model.dart';
import 'package:job_marketplace/models/response/auth/profile_model.dart';
import 'package:job_marketplace/routes/app_pages.dart';
import 'package:job_marketplace/utils/result.dart';
import 'package:job_marketplace/views/common/custom_btn.dart';
import 'package:job_marketplace/views/common/custom_textfield.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/height_spacer.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import '../../../cubit/login/login_cubit.dart';

class PersonalDetails extends StatefulWidget {
  final Map<String, dynamic>? arguments;
  const PersonalDetails({
    super.key,
    this.arguments,
  });

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController skill0 = TextEditingController();
  TextEditingController skill1 = TextEditingController();
  TextEditingController skill2 = TextEditingController();
  TextEditingController skill3 = TextEditingController();
  TextEditingController skill4 = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final ProfileRes profileRes;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    sl<ImageCubit>().clearImage();
    if (widget.arguments != null) {
      if (widget.arguments?['data'] != null) {
        profileRes = widget.arguments?['data'] as ProfileRes;
        phone.text = profileRes.phone;
        location.text = profileRes.location;
        if (profileRes.skills.isNotEmpty) {
          if (profileRes.skills.isNotEmpty) {
            skill0.text = profileRes.skills[0];
          }
          if (profileRes.skills.length > 1) {
            skill1.text = profileRes.skills[1];
          }
          if (profileRes.skills.length > 2) {
            skill2.text = profileRes.skills[2];
          }
          if (profileRes.skills.length > 3) {
            skill3.text = profileRes.skills[3];
          }
          if (profileRes.skills.length > 4) {
            skill4.text = profileRes.skills[4];
          }
        }
      } else {
        profileRes = ProfileRes(
          id: '',
          username: '',
          email: '',
          isAdmin: false,
          isAgent: false,
          skills: [],
          updatedAt: DateTime.now(),
          location: '',
          phone: '',
          profile: null,
        );
      }
    } else {
      profileRes = ProfileRes(
        id: '',
        username: '',
        email: '',
        isAdmin: false,
        isAgent: false,
        skills: [],
        updatedAt: DateTime.now(),
        location: '',
        phone: '',
        profile: null,
      );
    }
  }

  @override
  void dispose() {
    phone.dispose();
    location.dispose();
    skill0.dispose();
    skill1.dispose();
    skill2.dispose();
    skill3.dispose();
    skill4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listenWhen: (previous, current) =>
            previous.isProfileUpdate != current.isProfileUpdate,
        listener: (context, state) {
          if (state.isProfileUpdate?.status == Status.COMPLETED) {
            // sl<HomeCubit>().getUser();
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.MAINSCREEN, (route) => false);
          } else if (state.isProfileUpdate?.status == Status.ERROR) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    state.isProfileUpdate?.message ?? 'Something went wrong'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        buildWhen: (previous, current) =>
            previous.isProfileUpdate != current.isProfileUpdate,
        builder: (context, state) {
          if (state.isProfileUpdate?.status == Status.LOADING) {
            return buildBody(true, context);
          } else {
            return buildBody(false, context);
          }
        },
      ),
    );
  }

  Widget buildBody(bool isLoading, BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      opacity: 0.5,
      progressIndicator: Center(
        child: Lottie.asset('assets/json/loading.json'),
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 60.h,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReusableText(
                text: 'Personal Details',
                style: appstyle(
                  24,
                  Color(kDark.value),
                  FontWeight.w500,
                ),
              ),
              BlocBuilder<ImageCubit, ImageState>(
                builder: (context, state) {
                  return state.imageFile.isEmpty
                      ? GestureDetector(
                          onTap: () {
                            sl<ImageCubit>().pickImage();
                          },
                          child: profileRes.profile != null &&
                                  profileRes.profile != ''
                              ? CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                    profileRes.profile ?? '',
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Color(kLightBlue.value),
                                  child: const FaIcon(
                                    FontAwesomeIcons.fileImage,
                                  ),
                                ),
                        )
                      : GestureDetector(
                          onTap: () {
                            sl<ImageCubit>().clearImage();
                            setState(() {});
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundImage: FileImage(
                              File(
                                state.imageFile[0],
                              ),
                            ),
                          ),
                        );
                },
              )
            ],
          ),
          const HeightSpacer(size: 20),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: location,
                  hintText: 'Location',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your location';
                    }
                    return null;
                  },
                ),
                const HeightSpacer(size: 20),
                CustomTextField(
                  controller: phone,
                  hintText: 'Phone',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const HeightSpacer(size: 20),
                ReusableText(
                  text: 'Professional Skills',
                  style: appstyle(
                    24,
                    Color(kDark.value),
                    FontWeight.w500,
                  ),
                ),
                const HeightSpacer(size: 20),
                CustomTextField(
                  controller: skill0,
                  hintText: 'Professional Skills',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your skill';
                    }
                    return null;
                  },
                ),
                const HeightSpacer(size: 20),
                CustomTextField(
                  controller: skill1,
                  hintText: 'Professional Skills',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your skill';
                    }
                    return null;
                  },
                ),
                const HeightSpacer(size: 20),
                CustomTextField(
                  controller: skill2,
                  hintText: 'Professional Skills',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your skill';
                    }
                    return null;
                  },
                ),
                const HeightSpacer(size: 20),
                CustomTextField(
                  controller: skill3,
                  hintText: 'Professional Skills',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your skill';
                    }
                    return null;
                  },
                ),
                const HeightSpacer(size: 20),
                CustomTextField(
                  controller: skill4,
                  hintText: 'Professional Skills',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your skill';
                    }
                    return null;
                  },
                ),
                const HeightSpacer(size: 20),
                BlocBuilder<ImageCubit, ImageState>(
                  builder: (context, state) {
                    return CustomButton(
                      text: 'Update Profile',
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          sl<LoginCubit>().updateProfile(ProfileUpdateReq(
                            phone: phone.text,
                            location: location.text,
                            profile: state.imageUrl ?? profileRes.profile,
                            skills: [
                              skill0.text,
                              skill1.text,
                              skill2.text,
                              skill3.text,
                              skill4.text,
                            ],
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill the form'),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
