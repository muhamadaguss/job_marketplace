import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_marketplace/cubit/device_mgt/device_info_cubit.dart';
import 'package:job_marketplace/cubit/login/login_cubit.dart';
import 'package:job_marketplace/cubit/onBoarding/on_boarding_cubit.dart';
import 'package:job_marketplace/injector_container.dart';
import 'package:job_marketplace/routes/app_pages.dart';
import 'package:job_marketplace/views/common/app_bar.dart';
import 'package:job_marketplace/views/common/custom_outline_btn.dart';
import 'package:job_marketplace/views/common/drawer/drawer_widget.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/height_spacer.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/result.dart';

class DeviceManagement extends StatefulWidget {
  const DeviceManagement({super.key});

  @override
  State<DeviceManagement> createState() => _DeviceManagementState();
}

class _DeviceManagementState extends State<DeviceManagement> {
  @override
  void initState() {
    sl<DeviceInfoCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: const CustomAppBar(
          text: 'Device Management',
          child: DrawerWidget(),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<LoginCubit, LoginState>(
          listenWhen: (previous, current) =>
              previous.isLogin != current.isLogin,
          listener: (context, state) {
            if (state.isLogin?.status == Status.COMPLETED) {
              sl<OnBoardingCubit>().lastPage(false);
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.ONBOARDINGSCREEN,
                (route) => false,
              );
            }
          },
          buildWhen: (previous, current) => previous.isLogin != current.isLogin,
          builder: (context, state) {
            if (state.isLogin?.status == Status.LOADING) {
              return buildBody(true, context);
            } else {
              return buildBody(false, context);
            }
          },
        ),
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
      child: BlocBuilder<DeviceInfoCubit, DeviceInfoState>(
        buildWhen: (previous, current) =>
            previous.date != current.date ||
            previous.deviceData != current.deviceData ||
            previous.ipAddress != current.ipAddress,
        builder: (context, state) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeightSpacer(size: 50),
                    Text(
                      'Your are logged in into your account on these devices',
                      style: appstyle(
                        16,
                        Color(kDark.value),
                        FontWeight.normal,
                      ),
                    ),
                    const HeightSpacer(size: 20),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            right: 10.w,
                          ),
                          child: ReusableText(
                            text: 'Last login date',
                            style: appstyle(
                                14, Color(kDark.value), FontWeight.w500),
                          ),
                        ),
                        ReusableText(
                          text: state.date ?? '',
                          style: appstyle(
                              14, Color(kDarkGrey.value), FontWeight.w500),
                        ),
                      ],
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: state.deviceData != null
                          ? state.deviceData!.keys.map(
                              (String property) {
                                return Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                        right: 10.w,
                                      ),
                                      child: ReusableText(
                                        text: property,
                                        style: appstyle(14, Color(kDark.value),
                                            FontWeight.w500),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5.h),
                                        child: ReusableText(
                                          text:
                                              '${state.deviceData![property]}',
                                          style: appstyle(
                                              14,
                                              Color(kDarkGrey.value),
                                              FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ).toList()
                          : [],
                    ),
                    const HeightSpacer(size: 20),
                    CustomOutlineBtn(
                      onPressed: () {
                        sl<LoginCubit>().logout();
                      },
                      text: 'Sign Out',
                      color: Color(kLight.value),
                      width: width,
                      height: hieght * .05,
                      color2: Color(kOrange.value),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
