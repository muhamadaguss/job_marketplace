import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_marketplace/cubit/home/home_cubit.dart';
import 'package:job_marketplace/routes/app_pages.dart';
import 'package:job_marketplace/views/common/app_bar.dart';
import 'package:job_marketplace/views/common/drawer/drawer_widget.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/height_spacer.dart';
import 'package:job_marketplace/views/common/width_spacer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: const CustomAppBar(
          text: 'Profile',
          child: DrawerWidget(),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            previous.profileUpdateReq != current.profileUpdateReq,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 10.h,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  width: width,
                  height: hieght * .12,
                  color: Color(kLight.value),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20.r,
                          ),
                        ),
                        child: Image.network(
                          state.profileUpdateReq?.data?.profile ?? '',
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/user.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                      const WidthSpacer(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              state.profileUpdateReq?.data?.username ?? '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                              style: appstyle(
                                  16, Color(kDark.value), FontWeight.w500),
                            ),
                            Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.locationDot,
                                  color: Color(
                                    kDarkGrey.value,
                                  ),
                                ),
                                const WidthSpacer(width: 5),
                                ReusableText(
                                  text:
                                      state.profileUpdateReq?.data?.location ??
                                          '',
                                  style: appstyle(16, Color(kDarkGrey.value),
                                      FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.PERSONALDETAILS,
                              arguments: {
                                'data': state.profileUpdateReq?.data,
                                'isEdit': 'true'
                              });
                        },
                        child: FaIcon(
                          FontAwesomeIcons.penToSquare,
                          color: Color(kDarkGrey.value),
                          size: 18.sp,
                        ),
                      )
                    ],
                  ),
                ),
                const HeightSpacer(size: 20),
                Stack(
                  children: [
                    Container(
                      width: width,
                      height: hieght * .12,
                      color: Color(kLightGrey.value),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 20.w,
                            ),
                            width: 60.w,
                            height: 70.h,
                            color: Color(kLight.value),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.filePdf,
                                color: Colors.red,
                                size: 25.sp,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ReusableText(
                                text: 'Resume from John Doe',
                                style: appstyle(
                                    18, Color(kDark.value), FontWeight.w500),
                              ),
                              ReusableText(
                                text: 'Job Resume',
                                style: appstyle(16, Color(kDarkGrey.value),
                                    FontWeight.w500),
                              ),
                            ],
                          ),
                          const WidthSpacer(width: 1),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 2.h,
                      right: 10.w,
                      child: GestureDetector(
                        onTap: () {},
                        child: ReusableText(
                          text: 'Edit',
                          style: appstyle(
                            16,
                            Color(kOrange.value),
                            FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const HeightSpacer(size: 20),
                Container(
                  padding: EdgeInsets.only(left: 8.w),
                  width: width,
                  height: hieght * .06,
                  color: Color(kLightGrey.value),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ReusableText(
                      text: state.profileUpdateReq?.data?.email ?? '',
                      style: appstyle(16, Color(kDark.value), FontWeight.w500),
                    ),
                  ),
                ),
                const HeightSpacer(size: 20),
                Container(
                  padding: EdgeInsets.only(left: 8.w),
                  width: width,
                  height: hieght * .06,
                  color: Color(kLightGrey.value),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ReusableText(
                      text: state.profileUpdateReq?.data?.phone ?? '',
                      style: appstyle(16, Color(kDark.value), FontWeight.w500),
                    ),
                  ),
                ),
                const HeightSpacer(size: 20),
                Container(
                  padding: EdgeInsets.only(
                    left: 8.w,
                    right: 8.w,
                  ),
                  width: width,
                  color: Color(kLightGrey.value),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ReusableText(
                            text: 'Skills',
                            style: appstyle(
                              16,
                              Color(kDark.value),
                              FontWeight.w500,
                            ),
                          ),
                          const HeightSpacer(size: 3),
                          ListView.separated(
                            itemCount:
                                state.profileUpdateReq?.data?.skills.length ??
                                    0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const HeightSpacer(
                              size: 5,
                            ),
                            itemBuilder: (context, index) {
                              final skill =
                                  state.profileUpdateReq?.data?.skills[index];
                              return Container(
                                color: Color(kLight.value),
                                padding: EdgeInsets.only(
                                  left: 10.w,
                                  right: 10.w,
                                  top: 5.h,
                                  bottom: 5.h,
                                ),
                                child: ReusableText(
                                  text: '\u2022 $skill',
                                  style: appstyle(
                                    14,
                                    Color(kDarkGrey.value),
                                    FontWeight.w500,
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
