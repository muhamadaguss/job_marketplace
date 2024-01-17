import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_marketplace/cubit/home/home_cubit.dart';
import 'package:job_marketplace/routes/app_pages.dart';
import 'package:job_marketplace/utils/result.dart';
import 'package:job_marketplace/views/common/app_bar.dart';
import 'package:job_marketplace/views/common/drawer/drawer_widget.dart';
import 'package:job_marketplace/views/common/exports.dart';
import 'package:job_marketplace/views/common/heading_widget.dart';
import 'package:job_marketplace/views/common/height_spacer.dart';
import 'package:job_marketplace/views/common/search.dart';
import 'package:job_marketplace/views/common/vertical_shimmer.dart';
import 'package:job_marketplace/views/common/vertical_tile.dart';
import 'package:job_marketplace/views/ui/jobs/widgets/horizontal_shimmer.dart';
import 'package:job_marketplace/views/ui/jobs/widgets/horizontal_tile.dart';

import '../../injector_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    sl<HomeCubit>().getUser();
    sl<HomeCubit>().getJobAll();
    sl<HomeCubit>().getJobRecent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) =>
              previous.profileUpdateReq != current.profileUpdateReq,
          builder: (context, state) {
            return CustomAppBar(
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 12.w,
                    bottom: 2.h,
                  ),
                  child: state.profileUpdateReq?.data?.profile == null ||
                          state.profileUpdateReq?.data?.profile == ''
                      ? CircleAvatar(
                          radius: 25.r,
                          backgroundImage:
                              const AssetImage('assets/images/user.png'),
                        )
                      : CircleAvatar(
                          radius: 25.r,
                          backgroundImage: NetworkImage(
                            state.profileUpdateReq?.data?.profile ?? '',
                          ),
                        ),
                ),
              ],
              child: const DrawerWidget(),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeightSpacer(size: 10),
                    Text(
                      'Search\nFind & Apply',
                      style: appstyle(
                        40,
                        Color(kDark.value),
                        FontWeight.w600,
                      ),
                    ),
                    const HeightSpacer(size: 40),
                    SearchWidget(
                      onTap: () => Navigator.pushNamed(
                        context,
                        Routes.SEARCH,
                      ),
                    ),
                    const HeightSpacer(size: 30),
                    const HeadingWidget(
                      text: 'Popular Jobs',
                      onTap: null,
                    ),
                    const HeightSpacer(size: 15),
                    state.getJobAllReq?.status == Status.LOADING
                        ? const HorizontalShimmer()
                        : SizedBox(
                            height: hieght * .28,
                            child: ListView.builder(
                              itemCount: state.getJobAllReq?.data?.length ?? 0,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return JobHorizontalTile(
                                  job: state.getJobAllReq?.data?[index],
                                  onTap: () {
                                    Navigator.pushNamed(context, Routes.JOB,
                                        arguments: {
                                          'data':
                                              state.getJobAllReq?.data?[index],
                                        });
                                  },
                                );
                              },
                            ),
                          ),
                    const HeightSpacer(size: 20),
                    const HeadingWidget(
                      text: 'Recently Posts',
                      onTap: null,
                    ),
                    const HeightSpacer(size: 20),
                    state.getJobRecent?.status == Status.LOADING
                        ? const VerticalShimmer()
                        : ListView.separated(
                            itemCount: state.getJobRecent?.data?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const HeightSpacer(
                              size: 15,
                            ),
                            itemBuilder: (context, index) {
                              return VerticalTile(
                                job: state.getJobRecent?.data?[index],
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.JOB,
                                      arguments: {
                                        'data':
                                            state.getJobAllReq?.data?[index],
                                      });
                                },
                              );
                            },
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
